import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/provider/app_provider.dart';

class SplashView extends StatefulWidget {
  static const String routeName = 'splash-view';
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  Widget build(BuildContext context) {
    var appProvider = Provider.of<AppProvider>(context);

    Timer(
      const Duration(seconds: 1),
          () => Navigator.pushReplacementNamed(
          context, appProvider.isLoggedIn()),
    );

    return Image.asset(
      appProvider.splashScreen(),
      fit: BoxFit.cover,
    );
  }
}
