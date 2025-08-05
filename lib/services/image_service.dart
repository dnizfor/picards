import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:path_provider/path_provider.dart';

class ImageService {
  static String deviceLanguage =
      PlatformDispatcher.instance.locale.languageCode;

  static String generateFlashcardPrompt(String word, String mean) {
    return '''
Create a colorful, eye-catching flashcard-style illustration for the English word "$word" meaning "$mean".
Show the word "$word" in large, bold, playful letters at the top.
Illustrate the meaning "$mean" with a clear, memorable scene or object that visually explains it.
Make the style bright, cartoon-like, and friendly, similar to children's educational cards.
Ensure the design is simple, with minimal text other than the word, and the visual strongly conveys the meaning without needing translation.
''';
  }

  static Future<String> createAndDownloadImage(String word, String mean) async {
    final String prompt = generateFlashcardPrompt(word, mean);
    final response = await http.get(
      Uri.parse(
        'https://image.pollinations.ai/prompt/$prompt?model=turbo&nologo=true&private=true',
      ),
    );

    if (response.statusCode == 200) {
      // Uygulamanın documents klasörünü bul
      final dir = await getApplicationDocumentsDirectory();
      final filePath =
          '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Dosyaya yaz
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } else {
      throw Exception('Resim indirilemedi');
    }
  }
}
