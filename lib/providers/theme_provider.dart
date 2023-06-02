import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../utils/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeOption _selectedTheme = ThemeOption.light;

  ThemeOption get selectedTheme => _selectedTheme;

  void setTheme(ThemeOption theme) {
    _selectedTheme = theme;
    notifyListeners();
  }

  ThemeData getThemeData() {
    switch (_selectedTheme) {
      case ThemeOption.light:
        return AppThemes.lightTheme;
      case ThemeOption.dark:
        return AppThemes.darkTheme;
      case ThemeOption.dimTwitter:
        return AppThemes.dimTwitterTheme;
      case ThemeOption.nightTelegram:
        return AppThemes.nightTelegramTheme;
    }
  }
}
