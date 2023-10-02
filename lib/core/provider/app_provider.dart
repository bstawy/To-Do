import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool isLanguageBottomSheetVisible = false;
  bool isThemeBottomSheetVisible = false;
  bool isTaskAdderVisible = false;
  changeLanguageSheetStatus(String status) {
    if (status == 'open') {
      isLanguageBottomSheetVisible = true;
      isThemeBottomSheetVisible = false;
    } else {
      isLanguageBottomSheetVisible = false;
    }
    notifyListeners();
  }

  changeThemeSheetStatus(String status) {
    if (status == 'open') {
      isThemeBottomSheetVisible = true;
      isLanguageBottomSheetVisible = false;
    } else {
      isThemeBottomSheetVisible = false;
    }
    notifyListeners();
  }

  addNewTask() {
    isTaskAdderVisible = true;
    notifyListeners();
  }

  createNewTask() {
    isTaskAdderVisible = false;
    notifyListeners();
  }
}
