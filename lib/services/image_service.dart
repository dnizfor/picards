import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:ui';
import 'package:path_provider/path_provider.dart';

class ImageService {
  static String deviceLanguage =
      PlatformDispatcher.instance.locale.languageCode;

  static String generateFlashcardPrompt(String word, String mean) {
    return '''
Create a bright, colorful, and cartoon-style illustration representing the meaning of the English word "$word", which means "$mean".
Do NOT include any text in the image.
Focus on a simple, clear visual that conveys the meaning in an engaging and memorable way.
Use a friendly, child-educational style with bold colors and playful design.
The illustration should be easy to understand at a glance and visually convey "$mean".
''';
  }

  static Future<String> createAndDownloadImage(String word, String mean) async {
    final String prompt = generateFlashcardPrompt(word, mean);
    final response = await http.get(
      Uri.parse(
        'https://image.pollinations.ai/prompt/$prompt?model=flux&nologo=true&private=true',
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
