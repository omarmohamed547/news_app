import 'package:flutter/material.dart';
import 'package:news_route/models/category_model.dart';
import 'package:news_route/ui/category_fragment.dart';
import 'package:news_route/ui/home_screen/Home_drawer.dart';
import 'package:news_route/ui/category_deatils.dart';
import 'package:news_route/utils/app_style.dart';

class HomeScreen extends StatefulWidget {
  static const homeScreenId = "HomeScreen";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            selectedCategory == null ? "Home" : selectedCategory!.title,
            style: AppStyle.Medium20Black.copyWith(
                color: Theme.of(context).indicatorColor),
          ),
        ),
        body: selectedCategory == null
            ? CategoryFragment(
                onViewClicked: onViewClicked,
              )
            : categoryDetails(categoryModel: selectedCategory!),
        drawer: Drawer(
          backgroundColor: Theme.of(context).iconTheme.color,
          child: HomeDrawer(
            onTabDrwaer: () {
              selectedCategory = null;
              Navigator.pop(context);
              setState(() {});
            },
          ),
        ));
  }

  CategoryModel? selectedCategory;

  void onViewClicked(CategoryModel newCategory) {
    selectedCategory = newCategory;
    setState(() {});
  }
}
