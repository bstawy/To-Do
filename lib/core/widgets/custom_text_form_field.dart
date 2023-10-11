import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String title;
  final FormFieldValidator<String>? validator;
  final int maxLines;

  const CustomTextFormField({
    super.key,
    required this.title,
    required this.textEditingController,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return TextFormField(
      controller: textEditingController,
      validator: validator,
      maxLines: maxLines,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        hintText: title,
        hintStyle: theme.textTheme.bodyLarge!.copyWith(
          color: theme.colorScheme.onSecondary.withOpacity(0.5),
        ),
      ),
      style: theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onSecondary,
      )
    );
  }
}
