import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../../core/provider/app_provider.dart';
import '../../core/services/snackbar_service.dart';
import '../../pages/login_view/login_view.dart';
import '../../pages/settings/settings_view_model.dart';
import '../../pages/settings/widgets/custom_elevated_button.dart';
import '../../pages/settings/widgets/settings_item.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late SettingsViewModel settingsViewModel;

  @override
  void initState() {
    super.initState();
    settingsViewModel = SettingsViewModel();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);

    return ChangeNotifierProvider(
      create: (context) => settingsViewModel,
      builder: (context, child) {
        return Consumer<SettingsViewModel>(
          builder: (context, vm, child) {
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
                  selectedOption: vm.isDarkMode() ? 'Dark' : 'Light',
                  onClicked: () {
                    vm.showThemeBottomSheet(context, vm);
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
                  padding:
                      const EdgeInsets.only(top: 40, left: 56.0, bottom: 17),
                  child: Column(
                    children: [
                      CustomELevatedButton(
                          text: 'Change password',
                          onTap: () async {
                            EasyLoading.show();
                            await vm.changePassword();
                            EasyLoading.dismiss();

                            if (vm.changePasswordStatus == "success") {
                              SnackBarService.showAlertMessage(
                                  'A password reset link has been sent to your email');
                              Timer(const Duration(seconds: 3), () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    LoginView.routeName, (route) => false);
                              });
                            } else {
                              SnackBarService.showErrorMessage(
                                  '${vm.changePasswordStatus}');
                            }
                          }),
                      const SizedBox(height: 30),
                      CustomELevatedButton(
                        text: 'Delete account',
                        textStyle: theme.textTheme.bodyLarge!.copyWith(
                          color: const Color(0xffEE0E0E),
                        ),
                        borderColor: const Color(0xffEE0E0E),
                        foregroundColor: const Color(0xffEE0E0E),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
