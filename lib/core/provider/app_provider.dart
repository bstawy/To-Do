import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode? currentTheme ;
  SharedPreferences prefs;

  AppProvider(this.prefs) {
    bool isDark = prefs.getBool('isDark') ?? false;
    currentTheme = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  addThemeValueToSF(bool isDark) async {
    isDark ? prefs.setBool('isDark', true) : prefs.setBool('isDark', false);
  }

  changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    addThemeValueToSF(currentTheme == ThemeMode.dark);
    notifyListeners();
  }

  isDarkMode() => currentTheme == ThemeMode.dark;

  splashScreen() {
    return isDarkMode()
        ? 'assets/images/splash_dark.png'
        : 'assets/images/splash.png';
  }
}
