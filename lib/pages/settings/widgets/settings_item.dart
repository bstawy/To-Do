import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String settingOptionTitle, selectedOption;
  GestureTapCallback onClicked;

  SettingsItem({
    super.key,
    required this.settingOptionTitle,
    required this.selectedOption,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 38),
          child: Text(
            settingOptionTitle,
            style: theme.textTheme.titleSmall!
                .copyWith(color: const Color(0xff303030)),
          ),
        ),
        GestureDetector(
          onTap: () {
            onClicked();
          },
          child: Container(
            margin:
                const EdgeInsets.only(top: 17, left: 56, right: 37, bottom: 17),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: mediaQuery.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedOption,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(color: Colors.black,/*theme.colorScheme.primary*/),
                ),
                Icon(
                  Icons.arrow_drop_down_outlined,
                  color: Colors.black/*theme.colorScheme.primary*/,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
