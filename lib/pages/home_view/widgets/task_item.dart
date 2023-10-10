import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/core/network_layer/firestore_utils.dart';
import 'package:todo/core/utils/extract_time.dart';
import 'package:todo/pages/home_view/edit_task.dart';

import '../../../model/task_model.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 33, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Colors.teal,
            Color(0xffEC4B4B),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.5, 0.5],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(context, EditTask.routeName, arguments: task);
              },
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(15),
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) {
                FirestoreUtils.deleteDataFromFirestore(task);
              },
              backgroundColor: const Color(0xffEC4B4B),
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(15),
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          width: mediaQuery.width,
          height: 115,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            task.description,
                            style: theme.textTheme.bodyMedium!
                                .copyWith(color: theme.colorScheme.onSecondary),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.alarm,
                            color: theme.colorScheme.onSecondary.withOpacity(0.5),
                            size: 20,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            ExtractTime.formatDateToTime(task.time).format(context),
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.colorScheme.onSecondary.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 25,
                child: GestureDetector(
                  onTap: () {
                    task.isDone = !task.isDone;
                  },
                  child: Container(
                    width: 70,
                    height: 35,
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset('assets/images/check_icon.png'),
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
