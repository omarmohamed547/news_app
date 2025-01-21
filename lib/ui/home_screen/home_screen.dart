import 'package:flutter/material.dart';
import 'package:news_route/ui/home_screen/Home_drawer.dart';
import 'package:news_route/ui/category_deatils.dart';
import 'package:news_route/utils/app_style.dart';

class HomeScreen extends StatelessWidget {
  static const homeScreenId = "HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Home",
            style: AppStyle.Medium20Black.copyWith(
                color: Theme.of(context).indicatorColor),
          ),
        ),
        body: categoryDetails(),
        drawer: Drawer(
          backgroundColor: Theme.of(context).iconTheme.color,
          child: HomeDrawer(),
        ));
  }
}
