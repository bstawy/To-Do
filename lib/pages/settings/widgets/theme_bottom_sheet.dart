import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../settings_view_model.dart';
import 'selected_option_widget.dart';
import 'unselected_option_widget.dart';

class ThemeBottomSheetWidget extends StatefulWidget {
  final SettingsViewModel settingsViewModel;

  const ThemeBottomSheetWidget({
    super.key,
    required this.settingsViewModel,
  });

  @override
  State<ThemeBottomSheetWidget> createState() => _ThemeBottomSheetWidgetState();
}

class _ThemeBottomSheetWidgetState extends State<ThemeBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.settingsViewModel,
      builder: (context, child) {
        return Container(
          height: 350,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  widget.settingsViewModel.changeTheme(ThemeMode.light);
                  Navigator.pop(context);
                },
                child: widget.settingsViewModel.isDarkMode()
                    ? const UnselectedOption(unselectedOptionTitle: 'Light')
                    : const SelectedOption(selectedOptionTitle: 'Light'),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    widget.settingsViewModel.changeTheme(ThemeMode.dark);
                    Navigator.pop(context);
                  },
                  child: widget.settingsViewModel.isDarkMode()
                      ? const SelectedOption(selectedOptionTitle: 'Dark')
                      : const UnselectedOption(unselectedOptionTitle: 'Dark')),
            ],
          ),
        );
      },
    );
  }
}
