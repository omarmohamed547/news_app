import 'package:flutter/material.dart';
import 'package:news_route/di/di.dart';
import 'package:news_route/models/category_model.dart';
import 'package:news_route/models/source_response/source.dart';
import 'package:news_route/ui/category_details/cubit/source_states.dart';
import 'package:news_route/ui/category_details/cubit/source_view_model.dart';
import 'package:news_route/ui/category_fragment.dart';
import 'package:news_route/ui/home_screen/Home_drawer.dart';
import 'package:news_route/ui/category_details/category_deatils.dart';
import 'package:news_route/utils/app_style.dart';
import 'package:news_route/utils/search_dlegate.dart';

class HomeScreen extends StatefulWidget {
  static const homeScreenId = "HomeScreen";
  bool searchtextfield = false;
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SearchController searchController = SearchController();
  List<CategoryModel> categories =
      CategoryModel.getCategoryList(false); // Add category list
  CategoryModel? selectedCategory;
  List<Source> sources = [];
  Source? selectedSource;

  late sourceViewModel sourceviewmodel;

  @override
  void initState() {
    super.initState();
    sourceviewmodel = sourceViewModel(sourceRepository: injectSourceRepos());

    if (selectedCategory != null) {
      sourceviewmodel.getSource(selectedCategory!.id);
    }
  }

  void _onSourceSelected(Source source) {
    setState(() {
      selectedSource = source;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            selectedCategory == null ? "Home" : selectedCategory!.title,
            style: AppStyle.Medium20Black.copyWith(
                color: Theme.of(context).indicatorColor),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
            ),
          ]),

      body: selectedCategory == null
          ? CategoryFragment(
              onViewClicked: onViewClicked,
            )
          : categoryDetails(
              selectedSource: selectedSource, categoryModel: selectedCategory!),
      drawer: Drawer(
        backgroundColor: Theme.of(context).iconTheme.color,
        child: HomeDrawer(
          onTabDrwaer: () {
            setState(() {
              selectedCategory = null;
            });
            Navigator.pop(context);
          },
        ),
      ),
      drawerEnableOpenDragGesture:
          true, // Allow drawer swipe gesture even without AppBar
    );
  }

  void onViewClicked(CategoryModel newCategory) {
    setState(() {
      selectedCategory = newCategory;
      sourceviewmodel.getSource(
          selectedCategory!.id); // Fetch sources when a category is selected
    });
  }
}
