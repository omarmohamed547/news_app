import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_route/di/di.dart';
import 'package:news_route/ui/News/News_item.dart';
import 'package:news_route/ui/News/cubit/news_state.dart';
import 'package:news_route/ui/News/cubit/news_view_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  NewsViewModel newsViewModel = NewsViewModel(newsRepsitory: injectNewsRepos());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ""; // Clear search text
        },
      ),
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          newsViewModel.getNewsbySearch(query); // Trigger search

          showResults(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        iconTheme:
            IconThemeData(color: isDarkMode ? Colors.white : Colors.black),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.white, // TextField background always white
        hintStyle: TextStyle(color: Colors.grey),
        border: InputBorder.none,
      ),
      textTheme: const TextTheme(
        titleLarge:
            TextStyle(color: Colors.black), // Ensure text remains visible
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider.value(
      value: newsViewModel
        ..getNewsbySearch(query), // Ensure search is triggered

      child: BlocBuilder<NewsViewModel, NewsState>(
        builder: (context, state) {
          if (state is NewsSucessState) {
            if (state.newsList.isEmpty) {
              return const Center(child: Text("No results found"));
            }
            return ListView.builder(
              itemCount: state.newsList.length,
              itemBuilder: (context, index) {
                return NewsItem(news: state.newsList[index]);
              },
            );
          } else if (state is NewsFailureState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage,
                      style: Theme.of(context).textTheme.labelLarge),
                  ElevatedButton(
                    onPressed: () {
                      newsViewModel.getNewsbySearch(query);
                    },
                    child: const Text('Try Again'),
                  ),
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
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(child: Text("No News Found"));
    }
    return buildResults(context);
  }
}
