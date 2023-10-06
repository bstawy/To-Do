import 'package:flutter/material.dart';

class NewTaskBottomSheet extends StatefulWidget {
  const NewTaskBottomSheet({super.key});

  @override
  State<NewTaskBottomSheet> createState() => _NewTaskBottomSheetState();
}

class _NewTaskBottomSheetState extends State<NewTaskBottomSheet> {
  late TextEditingController taskNameController;
  late TextEditingController taskDescriptionController;
  DateTime? selectedDate = DateTime.now();

  @override
  void initState() {
    taskNameController = TextEditingController();
    taskDescriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Add new Task',
            style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          const Form(
            child: Column(
              children: [],
            ),
          ),
          GestureDetector(
            onTap: () => pickDate(),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                selectedDate
                    .toString()
                    .substring(0, selectedDate.toString().indexOf(' ')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  pickDate() async {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    setState(() {});
  }
}
