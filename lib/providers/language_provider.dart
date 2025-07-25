import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String nativeLanguageCode = '';
  String targetLanguageCode = '';

  void setNativeLanguageCode(String newNativeLanguageCode) {
    nativeLanguageCode = newNativeLanguageCode;
    notifyListeners();
  }

  void setTargetLanguageCode(String newTargetLanguageCode) {
    targetLanguageCode = newTargetLanguageCode;
    notifyListeners();
  }

  Future<void> initializeLanguageData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userNativeLanguageCode = prefs.getString(
      'nativeLanguageCode',
    );
    final String? usertargetLanguageCode = prefs.getString(
      'targetLanguageCode',
    );
    nativeLanguageCode = userNativeLanguageCode ?? "";
    targetLanguageCode = usertargetLanguageCode ?? "";

    notifyListeners();
  }
}
