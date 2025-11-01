import 'dart:convert';
import 'package:queue/queue.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:picards/models/deck_model.dart';
import 'package:picards/models/flashcard_model.dart';
import 'package:picards/navigation.dart';
import 'package:picards/providers/feed_provider.dart';
import 'package:picards/providers/language_provider.dart';
import 'package:picards/services/database_service.dart';
import 'package:picards/services/vertex_ai_service.dart';
import 'package:picards/widgets/vocabulary_card.dart';
import 'package:provider/provider.dart';

class DeckDetailScreen extends StatefulWidget {
  const DeckDetailScreen({super.key, this.deck});
  final Deck? deck;
  @override
  State<DeckDetailScreen> createState() => _DeckDetailScreenState();
}

class _DeckDetailScreenState extends State<DeckDetailScreen> {
  String deckName = "";
  int step = 0;
  List<Flashcard> flashcardList = [];
  final ValueNotifier<bool> _isFormValid = ValueNotifier(false);
  final TextEditingController _deckNameController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final queue = Queue(parallel: 1);

  @override
  void initState() {
    super.initState();

    loadFlashcardsForDeck();
  }

  Future<void> loadFlashcardsForDeck() async {
    if (widget.deck != null && widget.deck!.id != null) {
      final newFlashcardList = await DatabaseService.getFlashcardsByDeckId(
        widget.deck!.id!,
      );
      _deckNameController.text = widget.deck!.name;

      setState(() {
        flashcardList = newFlashcardList;
        deckName = widget.deck!.name;
      });
    }
  }

  void onFocusEnd() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> createImageForEx(int index, String langCode) async {
    if (flashcardList.isEmpty ||
        flashcardList[index].word!.trim().isEmpty ||
        flashcardList[index].mean!.trim().isEmpty) {
      return;
    }

    final Flashcard lastFlashcard = flashcardList[index];
    final String word = lastFlashcard.word!.trim();
    final String mean = lastFlashcard.mean!.trim();
    final String fileName = '$langCode-${word.toLowerCase()}';
    final storageRef = FirebaseStorage.instance.ref().child(
      'vocabulary-images/$fileName.png',
    );

    String? imageUrl;

    try {
      imageUrl = await storageRef.getDownloadURL().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          debugPrint('⏱️ Storage getDownloadURL timeout!');
          throw Exception('Storage timeout');
        },
      );
    } catch (e) {
      debugPrint(' $e');
    }

    // 🔧 Eğer görsel yoksa Vertex AI ile oluştur
    if (imageUrl == null) {
      String? imagePath;
      try {
        imagePath = await VertexAiService.createAndDownloadImage(word, mean)
            .timeout(
              const Duration(seconds: 40),
              onTimeout: () {
                throw Exception('Vertex AI timeout');
              },
            );

        if (imagePath.isEmpty) {
          debugPrint(
            '💥 Vertex AI returned an empty path, loading was aborted.',
          );
          return;
        }

        // 🔎 Dosya var mı kontrol et
        final file = File(imagePath);
        if (!file.existsSync()) {
          debugPrint('💥 File not found! Path: $imagePath');
          return;
        }

        // 🧩 Firebase Storage’a yükle
        await storageRef
            .putFile(file)
            .timeout(
              const Duration(seconds: 20),
              onTimeout: () {
                debugPrint('⏱️ putFile zaman aşımına uğradı!');
                throw Exception('Upload timeout');
              },
            );

        imageUrl = await storageRef.getDownloadURL().timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            throw Exception('URL fetch timeout');
          },
        );

        flashcardList[index].imagePath = imagePath;
      } catch (e) {
        debugPrint('⚠️ $e');
        return;
      }
    } else {
      // 🔽 Storage'daki görseli indirip cihazda sakla
      try {
        final tempDir = await getTemporaryDirectory();
        final localPath = '${tempDir.path}/$fileName.png';
        final response = await http
            .get(Uri.parse(imageUrl))
            .timeout(
              const Duration(seconds: 10),
              onTimeout: () {
                debugPrint('⏱️ HTTP indirme timeout!');
                throw Exception('Download timeout');
              },
            );

        final file = File(localPath);
        await file.writeAsBytes(response.bodyBytes);
        flashcardList[index].imagePath = localPath;
      } catch (e) {
        debugPrint('⚠️  $e');
      }
    }
  }

  Future<void> addEmptyFlashcard() async {
    final Flashcard newFlashcard = Flashcard(
      word: '',
      mean: '',
      example: '',
      exampleMean: '',
      imagePath: '',
    );

    setState(() {
      flashcardList.add(newFlashcard);
    });
    onFocusEnd();
    _isFormValid.value = false;
  }

  void deleteFlashcard(int index) {
    setState(() {
      flashcardList.removeAt(index);
    });
    _checkFormValid();
  }

  final _formKey = GlobalKey<FormState>();

  void _checkFormValid() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (_isFormValid.value != isValid) {
      _isFormValid.value = isValid; // 🔁 state yok, rebuild yok
    }
  }

  Future<void> onSubmit(
    LanguageProvider languageProvider,
    FeedProvider feedProvider,
  ) async {
    setState(() {
      step = 1;
    });
    // create image for last card

    queue.add(
      () => createImageForEx(
        flashcardList.length - 1,
        languageProvider.targetLanguageCode,
      ),
    );

    List<Map<String, dynamic>> partiallyEmptyExamplesWithIndex = [];

    for (int i = 0; i < flashcardList.length; i++) {
      final card = flashcardList[i];
      if (card.example!.trim().isEmpty || card.exampleMean!.trim().isEmpty) {
        partiallyEmptyExamplesWithIndex.add({'index': i, 'card': card});
      }
    }

    if (partiallyEmptyExamplesWithIndex.isNotEmpty) {
      final String response =
          await VertexAiService.sendRequestForExampleSentences(
            VertexAiService.generateCreateExampleSentencePropmt(
              cardsNeedingExamples: partiallyEmptyExamplesWithIndex,
              nativeLang: languageProvider.nativeLanguageCode,
              targetLang: languageProvider.targetLanguageCode,
            ),
          );

      List<dynamic> responseData = json.decode(response)['examples'];
      for (var i = 0; i < responseData.length; i++) {
        final int idexOfData = responseData[i]['index'];
        setState(() {
          flashcardList[idexOfData].example = responseData[i]['example'];
          flashcardList[idexOfData].exampleMean =
              responseData[i]['exampleMean'];
        });
      }
    }

    await queue.onComplete;

    if (widget.deck != null) {
      widget.deck!.name = deckName;
      await DatabaseService.updateExistingCollection(
        widget.deck!,
        flashcardList,
      );
    } else {
      await DatabaseService.onSaveNewCollection(deckName, flashcardList);
    }

    await feedProvider.updateDeckList();
    await feedProvider.updateFlashCardList();
    if (!mounted) return;
    setState(() {
      step = 2;
    });
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Navigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.read<LanguageProvider>();
    final feedProvider = Provider.of<FeedProvider>(context);

    if (step == 1) {
      return Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          size: 150,
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }
    if (step == 2) {
      return Center(
        child: Lottie.asset(
          'assets/lotties/successful_animation.json',
          repeat: false,
          width: 200,
          fit: BoxFit.fitWidth,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () => addEmptyFlashcard().then((value) {
              if (flashcardList.length > 1) {
                queue.add(
                  () => createImageForEx(
                    flashcardList.length - 2,
                    languageProvider.targetLanguageCode,
                  ),
                );
              }
            }),

            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(10),
              backgroundColor: Theme.of(
                context,
              ).colorScheme.primary, // <-- Button color
              foregroundColor: Colors.black, // <-- Splash color
            ),
            child: Icon(Icons.add, color: Colors.white, size: 30),
          ),
          SizedBox(height: 15),
          ValueListenableBuilder<bool>(
            valueListenable: _isFormValid,
            builder: (context, isValid, _) {
              return ElevatedButton(
                onPressed: !isValid || deckName == '' || flashcardList.isEmpty
                    ? null
                    : () => onSubmit(languageProvider, feedProvider),

                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.tertiary, // <-- Button color
                  foregroundColor: Colors.black, // <-- Splash color
                ),
                child: Icon(Icons.check, color: Colors.white, size: 30),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Form(
            key: _formKey,
            onChanged: () => _checkFormValid(),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return '';
                      }
                      return null;
                    },
                    controller: _deckNameController,
                    onChanged: (value) => setState(() {
                      deckName = value;
                    }),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      hintText: "deck name",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 30,
                    horizontal: 5,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Cards:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: scrollController,
                    itemBuilder: (BuildContext context, int index) =>
                        VocabularyCard(
                          word: flashcardList[index].word ?? '',
                          mean: flashcardList[index].mean ?? '',
                          key: UniqueKey(),
                          onDismissed: () => deleteFlashcard(index),
                          onChangedWord: (value) =>
                              flashcardList[index].word = value,

                          onChangedMean: (value) =>
                              flashcardList[index].mean = value,
                        ),
                    itemCount: flashcardList.length,
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
