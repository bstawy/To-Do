import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/provider/app_provider.dart';
import '../../pages/settings/widgets/language_bottom_sheet.dart';
import '../../pages/settings/widgets/settings_item.dart';
import '../../pages/settings/widgets/theme_bottom_sheet.dart';


class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);

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
          selectedOption: appProvider.isDarkMode() ? 'Dark' : 'Light',
          onClicked: () {
            showThemeBottomSheet(context);
          },
        ),
      ],
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const LanguageBottomSheetWidget(),
    );
  }

  void showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ThemeBottomSheetWidget(),
    );
  }
}
