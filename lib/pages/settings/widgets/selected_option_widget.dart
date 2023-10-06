import 'package:flutter/material.dart';

class SelectedOption extends StatelessWidget {
  final String selectedOptionTitle;
  const SelectedOption({super.key, required this.selectedOptionTitle});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black87,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedOptionTitle,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: Colors.black87,
            )
          ),
          const Icon(Icons.check),
        ],
      ),
    );
  }
}
