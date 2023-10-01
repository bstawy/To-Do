import 'package:flutter/material.dart';

import '../settings_view.dart';
import 'selected_option_widget.dart';
import 'unselected_option_widget.dart';

class ThemeBottomSheetWidget extends StatefulWidget {
  const ThemeBottomSheetWidget({super.key});

  @override
  State<ThemeBottomSheetWidget> createState() => _ThemeBottomSheetWidgetState();
}

class _ThemeBottomSheetWidgetState extends State<ThemeBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              //appProvider.changeLanguage('en');
              // Navigator.pop(context);
              SettingsView.isThemeBottomSheetVisible = false;
              setState(() {});
            },
            child: const SelectedOption(
              selectedOptionTitle: 'Light',
            ),
          ),
          GestureDetector(
            onTap: () {
              //appProvider.changeLanguage('ar');
              // Navigator.pop(context);
              SettingsView.isThemeBottomSheetVisible = false;
              setState(() {});
            },
            child: const UnselectedOption(
              unselectedOptionTitle: 'Dark',
            ),
          ),
        ],
      ),
    );
  }
}
