import 'package:flutter/material.dart';

class ApplicationTheme {
  static Color primaryColor = const Color(0xff5D9CEC);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: const Color(0xffDFECDB),
    ),
    scaffoldBackgroundColor: const Color(0xffDFECDB),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: false,
      toolbarHeight: 150,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins',
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
      ),
      selectedItemColor: primaryColor,
      unselectedIconTheme: IconThemeData(
        color: Colors.grey.shade700,
      ),
      unselectedItemColor: Colors.grey.shade700,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),

    textTheme: TextTheme(
      titleLarge: const TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins',
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: primaryColor,
        fontFamily: 'Poppins',
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: const TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: const TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: const TextStyle(
        color: Colors.black,
        fontFamily: 'Poppins',
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
  );
}
