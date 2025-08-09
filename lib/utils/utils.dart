import 'dart:math';

import 'package:picards/models/flashcard_model.dart';

class Utils {
  static const List<Map<String, String>> languagesData = [
    {"name": "Akan", "code": "ak"},
    {"name": "Amharic", "code": "am"},
    {"name": "Arabic", "code": "ar"},
    {"name": "Assamese", "code": "l_as"},
    {"name": "Aymara", "code": "ay"},
    {"name": "Azerbaijani", "code": "az"},
    {"name": "Belarusian", "code": "be"},
    {"name": "Bulgarian", "code": "bg"},
    {"name": "Bhojpuri", "code": "bho"},
    {"name": "Bislama", "code": "bi"},
    {"name": "Bambara", "code": "bm"},
    {"name": "Bengali", "code": "bn"},
    {"name": "Bosnian", "code": "bs"},
    {"name": "Catalan", "code": "ca"},
    {"name": "Cebuano", "code": "ceb"},
    {"name": "Chamorro", "code": "ch"},
    {"name": "Mari", "code": "chm"},
    {"name": "Corsican", "code": "co"},
    {"name": "Czech", "code": "cs"},
    {"name": "Welsh", "code": "cy"},
    {"name": "Danish", "code": "da"},
    {"name": "German", "code": "de"},
    {"name": "Divehi", "code": "dv"},
    {"name": "Dzongkha", "code": "dz"},
    {"name": "Greek", "code": "el"},
    {"name": "English", "code": "en"},
    {"name": "Spanish", "code": "es"},
    {"name": "Estonian", "code": "et"},
    {"name": "Basque", "code": "eu"},
    {"name": "Persian", "code": "fa"},
    {"name": "Finnish", "code": "fi"},
    {"name": "Filipino", "code": "fil"},
    {"name": "Fijian", "code": "fj"},
    {"name": "Faroese", "code": "fo"},
    {"name": "French", "code": "fr"},
    {"name": "Irish", "code": "ga"},
    {"name": "Galician", "code": "gl"},
    {"name": "Guarani", "code": "gn"},
    {"name": "Gujarati", "code": "gu"},
    {"name": "Manx", "code": "gv"},
    {"name": "Hausa", "code": "ha"},
    {"name": "Hawaiian", "code": "haw"},
    {"name": "Hebrew", "code": "he"},
    {"name": "Hindi", "code": "hi"},
    {"name": "Hiri Motu", "code": "ho"},
    {"name": "Croatian", "code": "hr"},
    {"name": "Haitian", "code": "ht"},
    {"name": "Hungarian", "code": "hu"},
    {"name": "Armenian", "code": "hy"},
    {"name": "Indonesian", "code": "id"},
    {"name": "Igbo", "code": "ig"},
    {"name": "Iloko", "code": "ilo"},
    {"name": "Icelandic", "code": "l_is"},
    {"name": "Italian", "code": "it"},
    {"name": "Japanese", "code": "ja"},
    {"name": "Javanese", "code": "jv"},
    {"name": "Georgian", "code": "ka"},
    {"name": "Kazakh", "code": "kk"},
    {"name": "Kalaallisut", "code": "kl"},
    {"name": "Central Khmer", "code": "km"},
    {"name": "Kannada", "code": "kn"},
    {"name": "Korean", "code": "ko"},
    {"name": "Krio", "code": "kri"},
    {"name": "Kurdish", "code": "ku"},
    {"name": "Kirghiz", "code": "ky"},
    {"name": "Latin", "code": "la"},
    {"name": "Luxembourgish", "code": "lb"},
    {"name": "Ganda", "code": "lg"},
    {"name": "Lingala", "code": "ln"},
    {"name": "Lao", "code": "lo"},
    {"name": "Lithuanian", "code": "lt"},
    {"name": "Luba-Katanga", "code": "lu"},
    {"name": "Latvian", "code": "lv"},
    {"name": "Malagasy", "code": "mg"},
    {"name": "Marshallese", "code": "mh"},
    {"name": "Maori", "code": "mi"},
    {"name": "Macedonian", "code": "mk"},
    {"name": "Malayalam", "code": "ml"},
    {"name": "Mongolian", "code": "mn"},
    {"name": "Marathi", "code": "mr"},
    {"name": "Western Mari", "code": "mrj"},
    {"name": "Malay", "code": "ms"},
    {"name": "Maltese", "code": "mt"},
    {"name": "Burmese", "code": "my"},
    {"name": "Nauru", "code": "na"},
    {"name": "Norwegian Bokmål", "code": "nb"},
    {"name": "North Ndebele", "code": "nd"},
    {"name": "Nepali", "code": "ne"},
    {"name": "Dutch", "code": "nl"},
    {"name": "Norwegian Nynorsk", "code": "nn"},
    {"name": "Norwegian", "code": "no"},
    {"name": "South Ndebele", "code": "nr"},
    {"name": "Chichewa", "code": "ny"},
    {"name": "Punjabi", "code": "pa"},
    {"name": "Papiamento", "code": "pap"},
    {"name": "Polish", "code": "pl"},
    {"name": "Pashto", "code": "ps"},
    {"name": "Portuguese", "code": "pt"},
    {"name": "Rundi", "code": "rn"},
    {"name": "Romanian", "code": "ro"},
    {"name": "Russian", "code": "ru"},
    {"name": "Kinyarwanda", "code": "rw"},
    {"name": "Sindhi", "code": "sd"},
    {"name": "Sango", "code": "sg"},
    {"name": "Sinhala", "code": "si"},
    {"name": "Slovak", "code": "sk"},
    {"name": "Slovenian", "code": "sl"},
    {"name": "Samoan", "code": "sm"},
    {"name": "Shona", "code": "sn"},
    {"name": "Somali", "code": "so"},
    {"name": "Albanian", "code": "sq"},
    {"name": "Serbian", "code": "sr"},
    {"name": "Swati", "code": "ss"},
    {"name": "Southern Sotho", "code": "st"},
    {"name": "Sundanese", "code": "su"},
    {"name": "Swedish", "code": "sv"},
    {"name": "Swahili", "code": "sw"},
    {"name": "Tamil", "code": "ta"},
    {"name": "Telugu", "code": "te"},
    {"name": "Tajik", "code": "tg"},
    {"name": "Thai", "code": "th"},
    {"name": "Turkmen", "code": "tk"},
    {"name": "Tagalog", "code": "tl"},
    {"name": "Tswana", "code": "tn"},
    {"name": "Tonga", "code": "to"},
    {"name": "Turkish", "code": "tr"},
    {"name": "Tahitian", "code": "ty"},
    {"name": "Ukrainian", "code": "uk"},
    {"name": "Urdu", "code": "ur"},
    {"name": "Uzbek", "code": "uz"},
    {"name": "Vietnamese", "code": "vi"},
    {"name": "Xhosa", "code": "xh"},
    {"name": "Yiddish", "code": "yi"},
    {"name": "Yoruba", "code": "yo"},
    {"name": "Yucateco", "code": "yua"},
    {"name": "Chinese - Traditional", "code": "zh_TW"},
    {"name": "Chinese", "code": "zh"},
    {"name": "Zulu", "code": "zu"},
  ];
  static String getLanguageFromCode(String languageCode) {
    for (var item in languagesData) {
      if (item['code'] == languageCode) {
        return item['name'] ?? 'Unknow';
      }
    }
    return 'Unknow';
  }

  static List<Map<String, dynamic>> createOptions(
    String selectedValue,
    List<Flashcard> allCards,
    String optionField,
  ) {
    Flashcard? selectedCard = allCards.firstWhere(
      (card) =>
          (optionField == 'word' ? card.word : card.mean) == selectedValue,
      orElse: () => throw Exception('Selected value not found in flashcards'),
    );

    List<Flashcard> others = allCards
        .where((card) => card.id != selectedCard.id)
        .toList();

    if (others.length < 2) {
      throw Exception('Not enough flashcards to create options');
    }

    final random = Random();
    Set<int> indices = {};
    while (indices.length < 2) {
      indices.add(random.nextInt(others.length));
    }

    List<Flashcard> options = indices.map((i) => others[i]).toList();
    options.add(selectedCard);
    options.shuffle(random);

    return options.map((card) {
      String optionValue;
      if (optionField == 'word') {
        optionValue = card.word!;
      } else if (optionField == 'mean') {
        optionValue = card.mean!;
      } else {
        throw Exception('optionField must be either "word" or "mean"');
      }

      return {'option': optionValue, 'answer': card.id == selectedCard.id};
    }).toList();
  }
}
