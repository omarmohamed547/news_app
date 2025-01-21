import 'package:flutter/material.dart';
import 'package:news_route/utils/app_style.dart';

class ThemeApp {
  static ThemeData lightTheme = ThemeData(
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      indicatorColor: Colors.black,
      textTheme: TextTheme(
          labelLarge: AppStyle.bold16Black,
          headlineMedium: AppStyle.Medium24Black),
      drawerTheme: DrawerThemeData(backgroundColor: Colors.black));

  static ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(
        labelLarge: AppStyle.bold16White,
        headlineMedium: AppStyle.Medium24White),
    primaryColor: Colors.black,
    indicatorColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    drawerTheme: DrawerThemeData(backgroundColor: Colors.white),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.black),
  );
}
