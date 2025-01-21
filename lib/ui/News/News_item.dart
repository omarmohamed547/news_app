import 'package:flutter/material.dart';
import 'package:news_route/models/news_response/news_response.dart';
import 'package:news_route/utils/app_style.dart';
import 'package:get_time_ago/get_time_ago.dart';

class NewsItem extends StatelessWidget {
  Article news;
  NewsItem({required this.news, super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var _dateTime = DateTime.now().subtract(
        Duration(minutes: news.publishedAt!.minute)); // [DateTime] object

    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.01),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).indicatorColor)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.02, vertical: height * 0.01),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                  fit: BoxFit.fill,
                  width: double.infinity,
                  news.urlToImage ?? ""),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              news.description ?? "",
              style: Theme.of(context).textTheme.labelLarge,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "By:${news.author ?? ""}",
                    style: AppStyle.Medium12Grey,
                  ),
                ),
                Text(
                  GetTimeAgo.parse(_dateTime),
                  style: AppStyle.Medium12Grey,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
