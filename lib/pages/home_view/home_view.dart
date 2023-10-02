import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/home_view/widgets/task_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
            CalendarTimeline(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2024, 12, 31),
              onDateSelected: (date) => print(date),
              leftMargin: 20,
              monthColor: theme.colorScheme.secondary,
              dayColor: Colors.teal[100],
              activeDayColor: theme.colorScheme.primary,
              activeBackgroundDayColor: Colors.white,
              dotsColor: Colors.white,
              selectableDayPredicate: (date) => date.day != 23,
            )
          ],
        ),
        const SizedBox(
          height: 65,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => const TaskItem(),
            itemCount: 20,

          ),
        )
      ],
    );
  }
}
