import 'package:flutter/material.dart';
import 'package:news_route/models/category_model.dart';
import 'package:news_route/providers/app_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class CategoryFragment extends StatelessWidget {
  CategoryFragment({super.key, required this.onViewClicked});
  Function onViewClicked;
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context).appThemeMode;
    var categoryList =
        CategoryModel.getCategoryList(themeProvider == ThemeMode.dark);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Good Morning\nHere is Some News For You",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (itemBuilder, index) {
                    return Stack(
                      alignment: index % 2 == 0
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(categoryList[index].imagePath)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.03,
                              vertical: height * 0.02),
                          child: ToggleSwitch(
                            customWidths: [width * 0.35, width * 0.10],
                            cornerRadius: 20.0,
                            activeBgColors: [
                              [Theme.of(context).primaryColor],
                              [Theme.of(context).primaryColor]
                            ],
                            inactiveBgColor: Colors.grey,
                            initialLabelIndex: 1,
                            totalSwitches: 2,
                            customWidgets: [
                              Text(
                                "View All",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Theme.of(context).indicatorColor,
                                ),
                              )
                            ],
                            radiusStyle: true,
                            onToggle: (index1) {
                              print('switched to: $index1');
                              onViewClicked(categoryList[index]);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (separatorBuilder, context) {
                    return SizedBox(
                      height: height * 0.02,
                    );
                  },
                  itemCount: categoryList.length))
        ],
      ),
    );
  }
}
