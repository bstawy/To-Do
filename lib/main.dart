import 'package:flutter/material.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/pages/splash_view/splash_view.dart';

void main() {
  runApp(const MyApplication());
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      initialRoute: SplashView.routeName,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        HomeLayout.routeName: (context) => const HomeLayout(),
      },
    );
  }
}
