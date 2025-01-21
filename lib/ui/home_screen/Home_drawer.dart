import 'package:flutter/material.dart';
import 'package:news_route/providers/app_theme_provider.dart';
import 'package:news_route/ui/home_screen/Theme_bootom_sheet.dart';
import 'package:news_route/utils/app_style.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      color: Color(0xff171717),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            height: height * 0.19,
            width: width * 0.72,
            child: Center(
              child: Text(
                "News App",
                style: AppStyle.bold24Black,
              ),
            ),
          ),
          RowForDrawer(
              image: "assets/icons/Home.png",
              text: "Go To Home",
              width: width,
              height: height),
          SizedBox(
            height: height * 0.02,
          ),
          Divider(
            endIndent: 20,
            indent: 13,
            thickness: 0.7,
            color: Colors.white,
          ),
          RowForDrawer(
              image: "assets/icons/themeIcon.png",
              text: "Theme",
              width: width,
              height: height),
          ContainerForThemeOrLanguage(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return ThemeBootomSheet(width: width, height: height);
                    });
              },
              text: themeProvider.appThemeMode == ThemeMode.dark
                  ? "Dark"
                  : themeProvider.appThemeMode == ThemeMode.light
                      ? "Light"
                      : "",
              width: width,
              height: height),
          Divider(
            endIndent: 20,
            indent: 13,
            thickness: 0.7,
            color: Colors.white,
          ),
          RowForDrawer(
              image: "assets/icons/langIcon.png",
              text: "Language",
              width: width,
              height: height),
          ContainerForThemeOrLanguage(
              text: "English", width: width, height: height),
        ],
      ),
    );
  }
}

class ContainerForThemeOrLanguage extends StatelessWidget {
  String text;
  void Function()? onTap;
  ContainerForThemeOrLanguage({
    this.onTap,
    required this.text,
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: height * 0.012),
              child: Text(
                text,
                style: AppStyle.Medium20White,
              ),
            ),
            Container(
                padding: EdgeInsets.only(right: width * 0.03),
                child: Image.asset("assets/icons/dopdownIcon.png")),
          ],
        ),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class RowForDrawer extends StatelessWidget {
  String image;
  String text;
  RowForDrawer({
    super.key,
    required this.image,
    required this.text,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: width * 0.02, left: width * 0.02, top: height * 0.02),
      child: Row(
        children: [
          Image.asset(image),
          SizedBox(
            width: width * 0.02,
          ),
          Text(
            text,
            style: AppStyle.bold16White.copyWith(fontSize: 20),
          )
        ],
      ),
    );
  }
}
