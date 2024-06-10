import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  bool _isEnglish = false;

  bool get isEnglish => _isEnglish;

  void toggleLanguage(bool isEnglish) {
    _isEnglish = isEnglish;
    notifyListeners();
  }
}
