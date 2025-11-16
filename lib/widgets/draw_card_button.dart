import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:picards/models/deck_model.dart';
import 'package:picards/models/flashcard_model.dart';
import 'package:picards/providers/feed_provider.dart';
import 'package:picards/providers/language_provider.dart';
import 'package:picards/screens/marathon_screen.dart';
import 'package:picards/services/database_service.dart';
import 'package:picards/services/vertex_ai_service.dart';
import 'package:picards/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';

class DrawCardButton extends StatefulWidget {
  const DrawCardButton({super.key});

  @override
  State<DrawCardButton> createState() => _DrawCardButtonState();
}

class _DrawCardButtonState extends State<DrawCardButton> {
  final GoogleTranslator translator = GoogleTranslator();

  Future<void> onTap() async {
    // Loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: SizedBox.expand(
          child: ColoredBox(
            color: Theme.of(context).colorScheme.shadow,
            child: Lottie.asset(
              'assets/lotties/cards_loading_animation.json',
              repeat: true,
              width: 300,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );

    final languageProvider = context.read<LanguageProvider>();
    final feedProvider = context.read<FeedProvider>();

    // 1️⃣ Kelimeleri İngilizce olarak al
    final List<dynamic> data = await Utils.getRandomWords(5);

    // 2️⃣ Flashcard oluştur ve çevirileri paralel yap
    final futures = data.map<Future<Flashcard>>((w) async {
      final englishWord = w["word"] as String;

      // Storage için kelime İngilizce
      String flashcardWord = englishWord;
      String flashcardMean = englishWord;

      // Hedef dil İngilizce değilse
      if (languageProvider.targetLanguageCode != 'en') {
        // word → target dil
        final translatedWord = await translator.translate(
          englishWord,
          from: 'en',
          to: languageProvider.targetLanguageCode,
        );
        flashcardWord = translatedWord.text;
      }
      // mean → native dil
      final translatedMean = await translator.translate(
        englishWord,
        from: 'en',
        to: languageProvider.nativeLanguageCode,
      );
      flashcardMean = translatedMean.text;
      return Flashcard(
        word: flashcardWord,
        mean: flashcardMean,
        example: "",
        exampleMean: "",
        imagePath: "",
      );
    }).toList();

    final flashcards = await Future.wait(futures);

    // 3️⃣ Firebase Storage görselleri indir (her zaman İngilizce ile)
    for (var card in flashcards) {
      final fileName =
          (card.word != null && languageProvider.targetLanguageCode != 'en')
          ? data.firstWhere((w) => w["word"] == card.word)["word"].toLowerCase()
          : card.word!.toLowerCase();

      final storageRef = FirebaseStorage.instance.ref(
        "vocabulary-images/$fileName.png",
      );

      try {
        final url = await storageRef.getDownloadURL();
        final tempDir = await getTemporaryDirectory();
        final localPath = "${tempDir.path}/$fileName.png";

        final response = await http.get(Uri.parse(url));
        final file = File(localPath);
        await file.writeAsBytes(response.bodyBytes);

        card.imagePath = localPath;
      } catch (e) {
        debugPrint("⚠️ Resim indirilemedi: $e");
      }
    }

    // 4️⃣ Vertex AI örnek cümle üret
    final List<Map<String, dynamic>> requestCards = [];
    for (int i = 0; i < flashcards.length; i++) {
      requestCards.add({"index": i, "card": flashcards[i]});
    }

    final response = await VertexAiService.sendRequestForExampleSentences(
      VertexAiService.generateCreateExampleSentencePropmt(
        cardsNeedingExamples: requestCards,
        nativeLang: languageProvider.nativeLanguageCode,
        targetLang: languageProvider.targetLanguageCode,
      ),
    );

    final examples = json.decode(response)["examples"] as List<dynamic>;
    for (var item in examples) {
      final i = item["index"] as int;
      String exampleText = item["example"] as String;
      String exampleMeanText = item["exampleMean"] as String;

      // Hedef dil İngilizce değilse örnek cümleleri çevir
      if (languageProvider.targetLanguageCode != 'en') {
        final translatedExample = await translator.translate(
          exampleText,
          from: 'en',
          to: languageProvider.targetLanguageCode,
        );
        final translatedExampleMean = await translator.translate(
          exampleMeanText,
          from: 'en',
          to: languageProvider.nativeLanguageCode,
        );
        exampleText = translatedExample.text;
        exampleMeanText = translatedExampleMean.text;
      }

      flashcards[i].example = exampleText;
      flashcards[i].exampleMean = exampleMeanText;
    }

    // 5️⃣ Deck oluştur ve kaydet
    const deckName = "Daily Marathon Deck";
    final deckId = await DatabaseService.onSaveNewCollection(
      deckName,
      flashcards,
    );

    await feedProvider.updateDeckList();
    await feedProvider.updateFlashCardList();

    final newDeck = Deck(id: deckId, name: deckName);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MarathonScreen(deck: newDeck)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          onTap: onTap,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Draw New Cards!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
