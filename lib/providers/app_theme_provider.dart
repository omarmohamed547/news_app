import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appThemeMode = ThemeMode.light;
  void changeThemeApp(ThemeMode newTheme) async {
    if (newTheme == appThemeMode) {
    } else {
      appThemeMode = newTheme;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('appThemeMode', '$newTheme');

    notifyListeners();
  }

  loadAppTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String savedTheme =
        prefs.getString('appThemeMode') ?? '${ThemeMode.light}';

    if (savedTheme == "${ThemeMode.dark}") {
      appThemeMode = ThemeMode.dark;
    } else if (savedTheme == "${ThemeMode.system}") {
      appThemeMode = ThemeMode.system;
    } else {
      appThemeMode = ThemeMode.light;
    }

    notifyListeners();
  }
}
