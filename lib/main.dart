import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_route/models/news_response/news_response.dart';
import 'package:news_route/models/source_response/source.dart';
import 'package:news_route/models/source_response/source_response.dart';
import 'package:news_route/providers/app_theme_provider.dart';
import 'package:news_route/ui/home_screen/home_screen.dart';
import 'package:news_route/utils/my_bloc_observer.dart';
import 'package:news_route/utils/theme_app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(SourceResponseAdapter());
  Hive.registerAdapter(SourceAdapter());
  Hive.registerAdapter(NewsResponseAdapter());
  Hive.registerAdapter(ArticleAdapter());
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
