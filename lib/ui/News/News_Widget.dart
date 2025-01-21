import 'package:flutter/material.dart';
import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/models/news_response/news_response.dart';
import 'package:news_route/models/source_response/source.dart';
import 'package:news_route/ui/News/News_item.dart';

class NewsWidget extends StatelessWidget {
  Source source;
  NewsWidget({required this.source, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponse?>(
        future: ApiManager.getNewsById(source.id ?? ""),
        builder: (builder, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.grey,
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Text('An error occured'),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Try Again'),
                  )
                ],
              ),
            );
          }

          //server response

          if (snapshot.data!.status == 'error') {
            return Center(
              child: Column(
                children: [
                  Text(snapshot.data!.message!),
                  ElevatedButton(
                    onPressed: () {
                      ApiManager.getNewsById(source.id ?? "");
                    },
                    child: Text('Try Again'),
                  )
                ],
              ),
            );
          } else {
            var newsList = snapshot.data!.articles;

            return ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (itemBuilder, index) {
                  return NewsItem(news: newsList[index]);
                });
          }
        });
  }
}
