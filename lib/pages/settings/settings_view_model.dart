import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/network_layer/firebase_utils.dart';
import 'package:todo/core/provider/app_provider.dart';
import 'package:todo/pages/settings/widgets/theme_bottom_sheet.dart';

class SettingsViewModel extends ChangeNotifier {
  ThemeMode currentTheme = AppProvider.currentTheme!;
  String _currentUserEmail = "";
  String _changePasswordStatus = "";

  String? get changePasswordStatus => _changePasswordStatus;

  isDarkMode() => currentTheme == ThemeMode.dark;

  void showThemeBottomSheet(
      BuildContext context, SettingsViewModel settingsViewModel) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          ThemeBottomSheetWidget(settingsViewModel: settingsViewModel),
    );
  }

  void showChangePasswordBottomSheet(
      context, SettingsViewModel settingsViewModel) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          ThemeBottomSheetWidget(settingsViewModel: settingsViewModel),
    );
  }

  addThemeValueToSharedPrefs(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark ? prefs.setBool("isDark", true) : prefs.setBool("isDark", false);
  }

  changeTheme(ThemeMode newTheme) {
    if (currentTheme == newTheme) return;
    currentTheme = newTheme;
    addThemeValueToSharedPrefs(currentTheme == ThemeMode.dark);
    AppProvider.currentTheme = currentTheme;
    notifyListeners();
  }

  changePassword() async {
    getCurrentUserEmail();
    if (_currentUserEmail.isEmpty) {
      return "failed";
    } else {
      _changePasswordStatus =
          await FirebaseUtils.resetPassword(_currentUserEmail);
      if (_changePasswordStatus.isEmpty) _changePasswordStatus = "invalid";
    }
    return "success";
  }

  getCurrentUserEmail() {
    _currentUserEmail = FirebaseUtils.getCurrentUserEmail();
  }
}
