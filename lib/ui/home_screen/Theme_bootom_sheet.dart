import 'package:flutter/material.dart';
import 'package:news_route/providers/app_theme_provider.dart';
import 'package:news_route/utils/app_style.dart';
import 'package:provider/provider.dart';

class ThemeBootomSheet extends StatelessWidget {
  const ThemeBootomSheet({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Container(
      margin: EdgeInsets.only(left: 0),
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: height * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      // width: width * 0.72,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              themeProvider.changeThemeApp(ThemeMode.dark);
            },
            child: themeProvider.appThemeMode == ThemeMode.dark
                ? SelectedWidget(text: "Dark")
                : Text(
                    "Dark",
                    style: AppStyle.Medium20Black,
                  ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          InkWell(
            onTap: () {
              themeProvider.changeThemeApp(ThemeMode.light);
            },
            child: themeProvider.appThemeMode == ThemeMode.light
                ? SelectedWidget(text: "Light")
                : Text(
                    "Light",
                    style: AppStyle.Medium20Black,
                  ),
          ),
        ],
      ),
    );
  }
}

class SelectedWidget extends StatelessWidget {
  String text;
  SelectedWidget({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppStyle.Medium20Black,
        ),
        Icon(
          Icons.check,
          size: 24,
          color: Colors.black,
        )
      ],
    );
  }
}
