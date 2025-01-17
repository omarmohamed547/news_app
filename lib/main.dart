import 'package:flutter/material.dart';
import 'package:news_route/ui/category_deatils.dart';
import 'package:news_route/ui/home_screen.dart';
import 'package:news_route/utils/theme_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.homeScreenId,
      darkTheme: ThemeApp.darkTheme,
      theme: ThemeApp.lightTheme,
      themeMode: ThemeMode.light,
      routes: {
        HomeScreen.homeScreenId: (context) => const HomeScreen(),
        categoryDetails.categoryDetailsId: (context) => const categoryDetails(),
      },
    );
  }
}
