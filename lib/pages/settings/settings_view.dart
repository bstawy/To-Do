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
      crossAxisAlignment: CrossAxisAlignment.start,
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
          settingOptionTitle: 'Theme',
          selectedOption: appProvider.isDarkMode() ? 'Dark' : 'Light',
          onClicked: () {
            showThemeBottomSheet(context);
          },
        ),
        const SizedBox(height: 32),
        Divider(
          color: theme.colorScheme.primary,
          thickness: 2,
          indent: 100,
          endIndent: 75,
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.only(left: 38.0),
          child: Text(
            "Account settings",
            style: theme.textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 56.0, bottom: 17),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: theme.primaryColor,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  minimumSize: Size(mediaQuery.width / 1.28, 50),
                  maximumSize: Size(mediaQuery.width / 1.28, 50),
                ),
                child: Row(
                  children: [
                    Text('Change password', style: theme.textTheme.bodyLarge),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: theme.colorScheme.onSecondary,
                      size: 18,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      color: Color(0xffEE0E0E),
                      width: 1,
                    ),
                  ),
                  foregroundColor: const Color(0xffEE0E0E),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  minimumSize: Size(mediaQuery.width / 1.28, 50),
                  maximumSize: Size(mediaQuery.width / 1.28, 50),
                ),
                child: Row(
                  children: [
                    Text(
                      'Delete account',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: const Color(0xffEE0E0E),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: theme.colorScheme.onSecondary,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        /*
        SettingsItem(
          settingOptionTitle: 'language',
          selectedOption: 'English',
          onClicked: () {
            showLanguageBottomSheet(context);
          },
        ),
        */
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
