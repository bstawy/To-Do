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
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white70,
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
            style: theme.textTheme.bodyLarge,
          ),
          const Icon(Icons.check),
        ],
      ),
    );
  }
}
