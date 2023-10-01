import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/settings/widgets/language_bottom_sheet.dart';
import 'package:todo/pages/settings/widgets/settings_item.dart';
import 'package:todo/pages/settings/widgets/theme_bottom_sheet.dart';
import '../../core/provider/app_provider.dart';

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
            if(!appProvider.isLanguageBottomSheetVisible) {
              appProvider.changeLanguageSheetStatus('open');
            }
          },
        ),
        const SizedBox(height: 40),
        SettingsItem(
          settingOptionTitle: 'Theme',
          selectedOption: 'Light',
          onClicked: () {
            if(!appProvider.isThemeBottomSheetVisible) {
              appProvider.changeThemeSheetStatus('open');
            }
          },
        ),
        Visibility(
          visible: appProvider.isLanguageBottomSheetVisible,
          child: Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const LanguageBottomSheetWidget(),
            ),
          ),
        ),
        Visibility(
          visible: appProvider.isThemeBottomSheetVisible,
          child: Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const ThemeBottomSheetWidget(),
            ),
          ),
        ),
      ],
    );
  }
}
