import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/settings/settings_view.dart';

import '../../../core/provider/app_provider.dart';
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
    var appProvider = Provider.of<AppProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            //appProvider.changeLanguage('en');
            //Navigator.pop(context);
            appProvider.changeLanguageSheetStatus('close');
          },
          child: const SelectedOption(
            selectedOptionTitle: 'English',
          ),
        ),
        GestureDetector(
          onTap: () {
            //appProvider.changeLanguage('ar');
            // Navigator.pop(context);
            appProvider.changeLanguageSheetStatus('close');
          },
          child: const UnselectedOption(
            unselectedOptionTitle: 'Arabic',
          ),
        ),
      ],
    );
  }
}
