import 'package:flutter/material.dart';
import 'package:news_route/models/news_response/article.dart';
import 'package:news_route/utils/app_style.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItem extends StatelessWidget {
  Article news;
  NewsItem({required this.news, super.key, this.searchtextfield = false});
  bool searchtextfield;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var _dateTime = DateTime.now().subtract(
        Duration(minutes: news.publishedAt!.minute)); // [DateTime] object

    return InkWell(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Theme.of(context).indicatorColor,
            context: context,
            builder: (builder) {
              return Container(
                margin: EdgeInsets.symmetric(
                    horizontal: width * 0.02, vertical: height * 0.01),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border:
                        Border.all(color: Theme.of(context).indicatorColor)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02, vertical: height * 0.01),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: news.urlToImage ?? "",
                            fit: BoxFit.fill,
                            width: double.infinity,
                            placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                              color: Colors.grey,
                            )),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          news.content ?? "",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.02),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                            onPressed: () {
                              _launchUrl();
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.01),
                              child: Text(
                                "View Full Articale",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: Column(
        children: [
          searchtextfield
              ? TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                            width: 1.5,
                            color: Theme.of(context).indicatorColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                            width: 1.5,
                            color: Theme.of(context).indicatorColor)),
                  ),
                )
              : SizedBox.shrink(),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.01),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).indicatorColor)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: news.urlToImage ?? "",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                        color: Colors.grey,
                      )),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
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
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse(news.url ?? ""))) {
      throw Exception('Could not launch ${Uri.parse(news.url ?? "")}');
    }
  }
}
