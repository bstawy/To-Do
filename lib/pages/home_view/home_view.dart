import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/network_layer/firestore_utils.dart';
import 'package:todo/core/utils/extract_date.dart';
import 'package:todo/pages/home_view/widgets/task_item.dart';

import '../../model/task_model.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Column(
      children: [
        Stack(
          alignment: const Alignment(0, 2.1),
          children: [
            Container(
              width: mediaQuery.width,
              height: 200,
              padding: const EdgeInsets.only(
                top: 65,
                left: 52,
              ),
              color: theme.primaryColor,
              child: Text(
                'To Do List',
                style: theme.textTheme.titleLarge,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.3),
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.secondary.withOpacity(0.3),
                    theme.colorScheme.background,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: CalendarTimeline(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2024, 12, 31),
                onDateSelected: (date) {
                  selectedDate = ExtractDate.extractDate(date);
                },
                leftMargin: 20,
                monthColor: theme.colorScheme.secondary,
                dayColor: Colors.teal[200],
                activeDayColor: theme.primaryColor,
                dotsColor: theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 65,
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirestoreUtils.getRealTimeDataFromFirestore(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.error.toString()),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => FirestoreUtils.getDataFromFirestore(),
                      child: const Text('Retry'),
                    ),
                  ],
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: theme.primaryColor,
                  ),
                );
              }

              var tasksList =
                  snapshot.data?.docs.map((element) => element.data()).toList() ?? [];
              return ListView.builder(
                itemBuilder: (context, index) =>
                    TaskItem(task: tasksList[index]),
                itemCount: tasksList.length,
                padding: const EdgeInsets.only(
                  top: 0,
                  bottom: 90,
                ),
              );
            },
          ),
        ),
        // Expanded(
        //   child: FutureBuilder<List<TaskModel>>(
        //     future: FirestoreUtils.getDataFromFirestore(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasError) {
        //         return Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Text(snapshot.error.toString()),
        //             const SizedBox(height: 20),
        //             ElevatedButton(
        //               onPressed: () => FirestoreUtils.getDataFromFirestore(),
        //               child: const Text('Retry'),
        //             ),
        //           ],
        //         );
        //       }
        //       else if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(
        //           child: CircularProgressIndicator(
        //             color: theme.primaryColor,
        //           ),
        //         );
        //       }
        //       var tasksList = snapshot.data ?? [];
        //       return ListView.builder(
        //         itemBuilder: (context, index) =>
        //             TaskItem(task: tasksList[index]),
        //         itemCount: tasksList.length,
        //         padding: const EdgeInsets.only(
        //           top: 0,
        //           bottom: 90,
        //         ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
