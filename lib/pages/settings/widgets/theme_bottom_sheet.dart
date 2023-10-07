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
              appProvider.changeTheme(ThemeMode.dark);
              Navigator.pop(context);
              //appProvider.changeThemeSheetStatus('close');
            },
            child: appProvider.isDarkMode()
                ? const SelectedOption(selectedOptionTitle: 'Dark')
                : const UnselectedOption(unselectedOptionTitle: 'Dark'),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              appProvider.changeTheme(ThemeMode.light);
              Navigator.pop(context);
              //appProvider.changeThemeSheetStatus('close');
            },
            child: appProvider.isDarkMode()
                ? const UnselectedOption(unselectedOptionTitle: 'Light')
                : const SelectedOption(selectedOptionTitle: 'Light'),
          ),
        ],
      ),
    );
  }
}
