import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }

  isDarkMode() => currentTheme == ThemeMode.dark;

  SplashScreen() {
    return isDarkMode()
        ? 'assets/images/splash_dark.png'
        : 'assets/images/splash.png';
  }
}
