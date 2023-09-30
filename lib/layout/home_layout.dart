import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'home-layout-view';
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment(0, 2.1),
        children: [
          Container(
            width: mediaQuery.width,
            height: 200,
            padding: EdgeInsets.only(
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/list_icon.png'),
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/settings_icon.png'),
            ),
            label: 'Tasks',
          ),
        ],
      ),
    );
  }
}
