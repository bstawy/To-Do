import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/widgets/custom_text_form_field.dart';

import '../../core/network_layer/firestore_utils.dart';
import '../../core/provider/app_provider.dart';
import '../../model/task_model.dart';

class EditTask extends StatefulWidget {
  static const String routeName = 'edit-task';
  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  var formKey = GlobalKey<FormState>();
  late TextEditingController taskTitleController;
  late TextEditingController taskDescriptionController;
  DateTime taskSelectedDate = DateTime.now();
  TimeOfDay taskSelectedTime = TimeOfDay.now();

  @override
  void initState() {
    taskTitleController = TextEditingController();
    taskDescriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as TaskModel;
    taskTitleController.text = args.title;
    taskDescriptionController.text = args.description;
    taskSelectedDate = args.date;
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
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  Text(
                    'Edit Task',
                    style: theme.textTheme.titleLarge!
                        .copyWith(color: theme.colorScheme.secondary),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 625,
              margin: const EdgeInsets.only(left: 30, right: 30, top: 150),
              padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 22),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        title: 'Title',
                        textEditingController: taskTitleController,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'You must provide task title';
                          } else if (value.length < 10) {
                            return 'Task title must be at least 10 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 35),
                      CustomTextFormField(
                        title: 'Description',
                        textEditingController: taskDescriptionController,
                        maxLines: 4,
                        validator: (String? value) {
                          if (taskDescriptionController.text == null ||
                              taskDescriptionController.text.trim().isEmpty) {
                            return 'You must provide description';
                          } else if (taskDescriptionController.text.length >
                              100) {
                            return 'Description must not be more than 100 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 50),
                      Text('Date', style: theme.textTheme.bodyLarge),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => pickDate(),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            taskSelectedDate.toString().substring(
                                0, taskSelectedDate.toString().indexOf(' ')),
                            style:
                                TextStyle(color: theme.colorScheme.onSecondary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 35),
                      Text('Time', style: theme.textTheme.bodyLarge),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => pickTime(),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.background,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            taskSelectedTime!.format(context),
                            style:
                                TextStyle(color: theme.colorScheme.onSecondary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 75),
                      Center(
                        child: MaterialButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              /*
                              var task = TaskModel(
                                title: taskTitleController.text,
                                description: taskDescriptionController.text,
                                date: taskSelectedDate,
                                time: taskSelectedDate,
                                isDone: false,
                              );

                              await FirestoreUtils.addDataToFirestore(task);
*/
                              Navigator.pop(context);
                            } else {
                              print(
                                  formKey.currentState!.validate().toString());
                            }
                          },
                          color: theme.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Text('Save Changes',
                              style: theme.textTheme.bodyLarge),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  pickDate() async {
    var selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      taskSelectedDate = selectedDate;
      setState(() {});
    }
  }

  pickTime() async {
    var selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null) {
      taskSelectedTime = selectedTime;
      setState(() {});
    }
  }
}
