import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/provider/app_provider.dart';

class EditTask extends StatefulWidget {
  static const String routeName = 'edit-task';
  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TimeOfDay taskSelectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: mediaQuery.width,
              height: 185,
              padding: const EdgeInsets.only(
                top: 60,
                left: 12,
              ),
              alignment: AlignmentDirectional.topStart,
              color: theme.primaryColor,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Edit Task',
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 450,
              margin: const EdgeInsets.only(
                  left: 30, right: 30, top: 150),
              padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'This is title',
                          hintStyle: theme.textTheme.bodyLarge!
                              .copyWith(color: Colors.grey)),
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 35),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Task details',
                          hintStyle: theme.textTheme.bodyLarge!
                              .copyWith(color: Colors.grey)),
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'Select time',
                      style: theme.textTheme.titleSmall!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => selectTime(),
                            child: Text(
                              taskSelectedTime.format(context),
                              style: theme.textTheme.bodyLarge!
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 50),
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            color: theme.colorScheme.primary,
                            height: 50,
                            hoverColor: theme.colorScheme.secondary,
                            minWidth: double.infinity,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              'Save Changes',
                              style: theme.textTheme.titleSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
