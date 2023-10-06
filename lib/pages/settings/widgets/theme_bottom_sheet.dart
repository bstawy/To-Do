import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/app_provider.dart';
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
    var appProvider = Provider.of<AppProvider>(context);

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
              //appProvider.changeThemeSheetStatus('close');
            },
            child: const SelectedOption(
              selectedOptionTitle: 'Light',
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              //appProvider.changeLanguage('ar');
              Navigator.pop(context);
              //appProvider.changeThemeSheetStatus('close');
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
