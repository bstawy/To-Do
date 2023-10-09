import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/widgets/new_task_bottom_sheet.dart';
import 'package:todo/pages/home_view/home_view.dart';
import 'package:todo/pages/settings/settings_view.dart';

import '../core/provider/app_provider.dart';

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
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      extendBody: true,
      floatingActionButton: CircleAvatar(
        backgroundColor: theme.colorScheme.secondary,
        radius: 32,
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              constraints: BoxConstraints.loose(const Size.fromHeight(700)),
              context: context,
              builder: (context) =>
                  const SingleChildScrollView(child: NewTaskBottomSheet()),
            );
            setState(() {});
          },
          elevation: 0,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: pages[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: theme.colorScheme.secondary.withAlpha(255),
        child: BottomNavigationBar(
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
      ),
    );
  }
}
