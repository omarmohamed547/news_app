import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData lightTheme = ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      indicatorColor: Colors.black,
      drawerTheme: DrawerThemeData(backgroundColor: Colors.black));

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    indicatorColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    drawerTheme: DrawerThemeData(backgroundColor: Colors.white),
    appBarTheme: AppBarTheme(centerTitle: true, backgroundColor: Colors.black),
  );
}
