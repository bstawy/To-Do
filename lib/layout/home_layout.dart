import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/home_view/home_view.dart';
import 'package:todo/pages/settings/settings_view.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'home-layout-view';
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIndex = 0;
  List<Widget> pages = const [HomeView(), SettingsView()];

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
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
