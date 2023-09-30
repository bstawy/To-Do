import 'dart:async';

import 'package:flutter/material.dart';

import '../../layout/home_layout.dart';

class SplashView extends StatefulWidget {
  static const String routeName = 'splash-view';
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, HomeLayout.routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/splash.png');
  }
}
