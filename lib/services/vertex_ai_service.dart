import 'package:firebase_ai/firebase_ai.dart';

class VertexAiService {
  static final jsonSchema = Schema.object(
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

  final model = FirebaseAI.vertexAI().generativeModel(
    model: 'gemini-2.0-flash-lite-001',
    generationConfig: GenerationConfig(
      responseMimeType: 'application/json',
      responseSchema: jsonSchema,
    ),
  );

  Future<String> sendRequest(String newPrompt) async {
    final prompt = [Content.text(newPrompt)];

    final response = await model.generateContent(prompt);

    return response.text!;
  }
}
