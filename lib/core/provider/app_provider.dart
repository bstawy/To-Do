import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/pages/login_view/login_view.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode? currentTheme ;
  SharedPreferences prefs;
  static String? userID;

  AppProvider(this.prefs) {
    bool isDark = prefs.getBool('isDark') ?? false;
    currentTheme = isDark ? ThemeMode.dark : ThemeMode.light;
    userID = prefs.getString('UID') ?? 'null';
    print('userID = $userID');
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

  isLoggedIn(){
    if(userID != 'null') {
      return HomeLayout.routeName;
    }
    return LoginView.routeName;
  }

  logIn(UserCredential user) {
    userID = user.user!.uid;
    prefs.setString('UID', userID!);
  }

  logOut() async {
    userID = 'null';
    prefs.setString('UID', 'null');
    await FirebaseAuth.instance.signOut();
  }
}
