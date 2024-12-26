import 'package:flutter/material.dart';
import '../shared_preferences/shared_preferences_functions.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = isDark == null ? ThemeMode.light : isDark! ? ThemeMode.dark: ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(int index) {

    if (index == 1 ) {
      _themeMode = ThemeMode.dark;
      setTheme(isDarkMode: true);
    } else {
      _themeMode = ThemeMode.light;
      setTheme(isDarkMode: false);

    }
    getTheme();
    notifyListeners();
  }
}

