import 'package:flutter/material.dart';
import 'package:news_route/ui/category_deatils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: categoryDetails.categoryDetailsId,
      routes: {
        categoryDetails.categoryDetailsId: (context) => const categoryDetails(),
      },
    );
  }
}
