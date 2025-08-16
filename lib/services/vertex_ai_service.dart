import 'dart:math';

import 'package:firebase_ai/firebase_ai.dart';
import 'package:picards/models/flashcard_model.dart';

class VertexAiService {
  static final jsonSchemaForExampleSentences = Schema.object(
    properties: {
      'examples': Schema.array(
        items: Schema.object(
          properties: {
            'index': Schema.integer(),
            'example': Schema.string(),
            'exampleMean': Schema.string(),
          },
        ),
      ),
    },
  );

  static String generateCreateExampleSentencePropmt({
    required List<Map<String, dynamic>> cardsNeedingExamples,
    required String nativeLang,
    required String targetLang,
  }) {
    final wordList = cardsNeedingExamples
        .map(
          (item) =>
              'index: ${item["index"]}, word: "${item['card'].word}", meaning: "${item['card'].mean}"',
        )
        .join('\n');

    return '''Generate a simple example sentence in $targetLang for each of the following words. Also provide the translation in $nativeLang.Words:$wordList''';
  }

  static Future<String> sendRequestForExampleSentences(String newPrompt) async {
    final model = FirebaseAI.vertexAI().generativeModel(
      model: 'gemini-2.0-flash-lite-001',
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: jsonSchemaForExampleSentences,
      ),
    );
    final prompt = [Content.text(newPrompt)];

    final response = await model.generateContent(prompt);

    return response.text!;
  }

  static final jsonSchemaForQuestion = Schema.object(
    properties: {'question': Schema.string()},
  );

  static Future<String> createQuestionForWord(
    String targetLanguage,
    String word,
  ) async {
    final model = FirebaseAI.vertexAI().generativeModel(
      model: 'gemini-2.0-flash-lite-001',
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: jsonSchemaForQuestion,
      ),
    );
    final prompt = [
      Content.text(
        'Create a question sentence in $targetLanguage language in which I can use the word "$word" when answering.The answer to the question should not be that word directly, the user should answer by using the word in a sentence.',
      ),
    ];

    final response = await model.generateContent(prompt);

    return response.text!;
  }

  static final jsonSchemaForUserAnswer = Schema.object(
    properties: {'check': Schema.boolean()},
  );

  static Future<String> checkUserAnswer(
    String question,
    String answer,
    String word,
  ) async {
    final model = FirebaseAI.vertexAI().generativeModel(
      model: 'gemini-2.0-flash-lite-001',
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: jsonSchemaForUserAnswer,
      ),
    );
    final prompt = [
      Content.text(
        'The user was asked the question: "$question". The user answered: "$answer". Is this answer correct? The user uses the word $word when answering',
      ),
    ];

    final response = await model.generateContent(prompt);

    return response.text!;
  }

  static String createGapFillingTextPropmt(String targetLanguage, String word) {
    Random random = Random();
    int randomNumber = random.nextInt(100);
    return "Write an example sentence in $targetLanguage language using the word $word. Replace the word with __ in the sentence."
        "'seed': $randomNumber";
  }

  static final jsonSchemaForGapFillingText = Schema.object(
    properties: {'text': Schema.string()},
  );
  static Future<String> sendRequestForGapFillingText(String newPrompt) async {
    final model = FirebaseAI.vertexAI().generativeModel(
      model: 'gemini-2.0-flash-lite-001',
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: jsonSchemaForGapFillingText,
      ),
    );
    final prompt = [Content.text(newPrompt)];

    final response = await model.generateContent(prompt);

    return response.text!;
  }

  static String createStoryPropmt(
    String targetLanguage,
    List<Flashcard> flashcardList,
  ) {
    String words = flashcardList.map((e) => e.word.toString()).join(", ");

    return "Write a story in $targetLanguage. The story should naturally include the following words: $words. ";
  }

  static final jsonSchemaForCreateStory = Schema.object(
    properties: {'story': Schema.string()},
  );
  static Future<String> sendRequestForCreateStory(String newPrompt) async {
    final model = FirebaseAI.vertexAI().generativeModel(
      model: 'gemini-2.0-flash-lite-001',
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: jsonSchemaForCreateStory,
      ),
    );

    final prompt = [Content.text(newPrompt)];

    final response = await model.generateContent(prompt);

    return response.text!;
  }
}
