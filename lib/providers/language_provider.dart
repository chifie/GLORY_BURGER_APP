import 'package:flutter/material.dart';

/// Provider that manages the app's language setting.
/// Supports English ('en') and Tanzanian Swahili ('sw').
class LanguageProvider extends ChangeNotifier {
  String _languageCode = 'en';

  String get languageCode => _languageCode;
  String get languageName => _languageCode == 'sw' ? 'Kiswahili' : 'English';

  /// Set the language
  void setLanguage(String code) {
    if (code == 'en' || code == 'sw') {
      _languageCode = code;
      notifyListeners();
    }
  }

  /// Toggle between English and Swahili
  void toggleLanguage() {
    _languageCode = _languageCode == 'en' ? 'sw' : 'en';
    notifyListeners();
  }
}