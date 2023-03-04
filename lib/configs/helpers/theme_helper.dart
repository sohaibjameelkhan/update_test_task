import 'package:flutter/material.dart';

enum ThemeType { light, dark }

class ThemeProvider with ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();
  ThemeType currentType = ThemeType.light;

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    if (currentType == ThemeType.light) {
      currentType = ThemeType.dark;
      _currentTheme = ThemeData.dark();
    } else {
      currentType = ThemeType.light;
      _currentTheme = ThemeData.light();
    }
    notifyListeners();
  }
}
