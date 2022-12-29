import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Varela',
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontFamily: 'Varela',
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
   iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.blue.shade700,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue.shade700,
    unselectedItemColor: Colors.grey.shade500,
    selectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
    ),
    selectedIconTheme: const IconThemeData(
      size: 27.0,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 14.0,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.blue.shade700,
  ),
);

ThemeData darkTheme = ThemeData();
