import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkModeOn = false;

  bool get isDarkModeOn => _isDarkModeOn;

  void toggleTheme() {
    _isDarkModeOn = !_isDarkModeOn;
    notifyListeners();
  }
}
