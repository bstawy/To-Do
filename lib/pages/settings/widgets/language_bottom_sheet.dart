import 'package:flutter/material.dart';
import 'package:todo/pages/settings/settings_view.dart';

import 'selected_option_widget.dart';
import 'unselected_option_widget.dart';

class LanguageBottomSheetWidget extends StatefulWidget {
  const LanguageBottomSheetWidget({super.key});

  @override
  State<LanguageBottomSheetWidget> createState() =>
      _LanguageBottomSheetWidgetState();
}

class _LanguageBottomSheetWidgetState extends State<LanguageBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            //appProvider.changeLanguage('en');
            //Navigator.pop(context);
            SettingsView.isLanguageBottomSheetVisible = false;
            setState(() {});
          },
          child: const SelectedOption(
            selectedOptionTitle: 'English',
          ),
        ),
        GestureDetector(
          onTap: () {
            //appProvider.changeLanguage('ar');
            // Navigator.pop(context);
            SettingsView.isLanguageBottomSheetVisible = false;
            setState(() {});
          },
          child: const UnselectedOption(
            unselectedOptionTitle: 'Arabic',
          ),
        ),
      ],
    );
  }
}
