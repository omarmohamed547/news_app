import 'package:flutter/material.dart';
import 'package:news_route/providers/app_theme_provider.dart';
import 'package:news_route/ui/category_details/category_deatils.dart';
import 'package:news_route/ui/home_screen/home_screen.dart';
import 'package:news_route/utils/theme_app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppThemeProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.homeScreenId,
      darkTheme: ThemeApp.darkTheme,
      theme: ThemeApp.lightTheme,
      themeMode: themeProvider.appThemeMode,
      routes: {
        HomeScreen.homeScreenId: (context) => HomeScreen(),
      },
    );
  }
}
