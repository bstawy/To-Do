import 'package:flutter/material.dart';
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
    return Container(
      height: 350,
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              //appProvider.changeLanguage('en');
              Navigator.pop(context);
            },
            child: const SelectedOption(
              selectedOptionTitle: 'English',
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              //appProvider.changeLanguage('ar');
              Navigator.pop(context);
            },
            child: const UnselectedOption(
              unselectedOptionTitle: 'Arabic',
            ),
          ),
        ],
      ),
    );
  }
}
