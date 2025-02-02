import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/di/di.dart';
import 'package:news_route/models/news_response/news_response.dart';
import 'package:news_route/models/source_response/source.dart';
import 'package:news_route/ui/News/News_item.dart';
import 'package:news_route/ui/News/cubit/news_state.dart';
import 'package:news_route/ui/News/cubit/news_view_model.dart';
import 'package:provider/provider.dart';

class NewsWidget extends StatefulWidget {
  Source source;
  NewsWidget({required this.source, super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  NewsViewModel newsViewModel = NewsViewModel(newsRepsitory: injectNewsRepos());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    newsViewModel.getNews(widget.source.id!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => newsViewModel,
      child: BlocBuilder<NewsViewModel, NewsState>(
        builder: (context, state) {
          if (state is NewsSucessState) {
            return ListView.builder(
                itemCount: state.newsList.length,
                itemBuilder: (itemBuilder, index) {
                  return NewsItem(news: state.newsList[index]);
                });
          } else if (state is NewsFailureState) {
            return Center(
              child: Column(
                children: [
                  Text(state.errorMessage),
                  ElevatedButton(
                    onPressed: () {
                      newsViewModel.getNews(widget.source.id ?? "");
                    },
                    child: Text('Try Again'),
                  )
                ],
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.grey,
            ));
          }
        },
      ),
    );

    /* FutureBuilder<NewsResponse?>(
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
                    return NewsItem(
                      
                      news: newsList[index]);
                  });
            }
          }),*/
  }
}
