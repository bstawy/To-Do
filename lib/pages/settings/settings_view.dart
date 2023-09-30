import 'package:flutter/material.dart';
import 'package:todo/pages/settings/widgets/language_bottom_sheet.dart';
import 'package:todo/pages/settings/widgets/settings_item.dart';
import 'package:todo/pages/settings/widgets/theme_bottom_sheet.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Column(
      children: [
        Container(
          width: mediaQuery.width,
          height: 200,
          padding: const EdgeInsets.only(
            top: 65,
            left: 52,
          ),
          color: theme.primaryColor,
          child: Text(
            'Settings',
            style: theme.textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 25),
        SettingsItem(
          settingOptionTitle: 'language',
          selectedOption: 'English',
          onClicked: () {
            showLanguageBottomSheet(context);
          },
        ),
        const SizedBox(height: 40),
        SettingsItem(
          settingOptionTitle: 'Theme',
          selectedOption: 'Light',
          onClicked: () {
            showLanguageBottomSheet(context);
          },
        ),
      ],
    );
  }
  void showLanguageBottomSheet(context) {
    var theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      builder: (context) => const LanguageBottomSheetWidget(),
    );
  }

  void showThemeBottomSheet(context) {
    var theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      builder: (context) => const ThemeBottomSheetWidget(),
    );
  }
}