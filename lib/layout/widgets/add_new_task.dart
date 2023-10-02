import 'package:flutter/material.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final taskNameController = TextEditingController();
  TimeOfDay taskSelectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2.3,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 22),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            'Add new Task',
            style: theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.secondary),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: taskNameController,
            decoration: InputDecoration(
                hintText: 'Enter task name',
                hintStyle:
                    theme.textTheme.bodyLarge!.copyWith(color: Colors.white30)),
            style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 35),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select time',
              textAlign: TextAlign.start,
              style: theme.textTheme.titleSmall!
                  .copyWith(color: theme.colorScheme.secondary, fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => selectTime(),
            child: Text(
              taskSelectedTime.format(context),
              style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  selectTime() async {
    TimeOfDay currentTime = TimeOfDay.now();
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    if (selectedTime != null) {
      setState(() {
        taskSelectedTime = selectedTime;
      });
    }
  }
}
