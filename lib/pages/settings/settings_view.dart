import 'package:flutter/material.dart';
import 'package:todo/pages/settings/widgets/language_bottom_sheet.dart';
import 'package:todo/pages/settings/widgets/settings_item.dart';
import 'package:todo/pages/settings/widgets/theme_bottom_sheet.dart';

class SettingsView extends StatefulWidget {
  static bool isLanguageBottomSheetVisible = false;
  static bool isThemeBottomSheetVisible = false;

  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {


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
            if(SettingsView.isThemeBottomSheetVisible) {
              SettingsView.isThemeBottomSheetVisible = false;
            }
            setState(() {
              SettingsView.isLanguageBottomSheetVisible = true;
            });
          },
        ),
        const SizedBox(height: 40),
        SettingsItem(
          settingOptionTitle: 'Theme',
          selectedOption: 'Light',
          onClicked: () {
            if(SettingsView.isLanguageBottomSheetVisible) {
              SettingsView.isLanguageBottomSheetVisible = false;
            }
            setState(() {
              SettingsView.isThemeBottomSheetVisible = true;
            });
          },
        ),
        Visibility(
          visible: SettingsView.isLanguageBottomSheetVisible,
          child: Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: LanguageBottomSheetWidget(),
            ),
          ),
        ),
        Visibility(
          visible: SettingsView.isThemeBottomSheetVisible,
          child: Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ThemeBottomSheetWidget(),
            ),
          ),
        ),
      ],
    );
  }

  void showLanguageBottomSheet(context) {

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
