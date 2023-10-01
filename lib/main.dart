import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/provider/app_provider.dart';
import 'package:todo/core/theme/application_theme.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/pages/splash_view/splash_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApplication(),
    ),
  );
}

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      themeMode: ThemeMode.light,
      theme: ApplicationTheme.lightTheme,
      initialRoute: SplashView.routeName,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        HomeLayout.routeName: (context) => const HomeLayout(),
      },
    );
  }
}
