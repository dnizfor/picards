import 'dart:convert';

import 'package:flutter/material.dart';
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
  List<Flashcard> flashcardList = [];
  final ValueNotifier<bool> _isFormValid = ValueNotifier(false);
  final TextEditingController _deckNameController = TextEditingController();
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

  void addEmptyFlashcard() {
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
    List<Map<String, dynamic>> partiallyEmptyExamplesWithIndex = [];

    for (int i = 0; i < flashcardList.length; i++) {
      final card = flashcardList[i];
      if (card.example!.trim().isEmpty || card.exampleMean!.trim().isEmpty) {
        partiallyEmptyExamplesWithIndex.add({'index': i, 'card': card});
      }
    }

    if (partiallyEmptyExamplesWithIndex.isNotEmpty) {
      final String response = await VertexAiService().sendRequest(
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

    if (widget.deck != null) {
      widget.deck!.name = deckName;
      await DatabaseService.updateExistingCollection(
        widget.deck!,
        flashcardList,
      );
    } else {
      await DatabaseService.onSaveNewCollection(deckName, flashcardList);
    }

    await feedProvider.updateFlashCardList();
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Navigation()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.read<LanguageProvider>();
    final feedProvider = Provider.of<FeedProvider>(context);

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: addEmptyFlashcard,
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

                          onUnfocus: (value) =>
                              flashcardList[index].imagePath = value,
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
