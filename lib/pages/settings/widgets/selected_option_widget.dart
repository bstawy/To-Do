import 'package:flutter/material.dart';

class SelectedOption extends StatelessWidget {
  final String selectedOptionTitle;
  const SelectedOption({super.key, required this.selectedOptionTitle});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.primary,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedOptionTitle,
            style: theme.textTheme.bodyLarge!.copyWith(color: theme.colorScheme.primary),
          ),
          Icon(Icons.check, color: theme.colorScheme.primary,),
        ],
      ),
    );
  }
}
