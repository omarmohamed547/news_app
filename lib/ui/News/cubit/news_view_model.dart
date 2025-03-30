import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/models/news_response/article.dart';
import 'package:news_route/repository/news/dataSource/news_remote_dataSource.dart';
import 'package:news_route/repository/news/dataSource/news_remote_dataSource_impl.dart';
import 'package:news_route/repository/news/repository/news_repsitory.dart';
import 'package:news_route/repository/news/repository/news_rpository_impl.dart';
import 'package:news_route/ui/News/cubit/news_state.dart';

class NewsViewModel extends Cubit<NewsState> {
  NewsRepsitory newsRepsitory;
  int _currentPage = 1; // Default page is 1
  bool _isFetching = false; // Prevent multiple requests
  List<Article> newsList = []; // Store loaded news articles

  NewsViewModel({required this.newsRepsitory}) : super(NewsLoadingState());

  // Fetch first news page
  void getNews(String sourcId) async {
    if (_isFetching) return;
    _isFetching = true;

    _currentPage = 1; // Reset page count
    newsList.clear(); // Clear old data

    try {
      emit(NewsLoadingState());
      var response = await newsRepsitory.getNewsById(sourcId, _currentPage);
      if (response == null || response.status == 'error') {
        emit(NewsFailureState(
            errorMessage: response?.message ?? "Unknown error"));
      } else {
        newsList = response.articles;
        emit(NewsSucessState(newsList: List.from(newsList)));
        _currentPage++;
      }
    } catch (e) {
      emit(NewsFailureState(errorMessage: e.toString()));
    } finally {
      _isFetching = false;
    }
  }

  void loadMoreNews(String sourceId) async {
    if (_isFetching || newsList.isEmpty) return; // Prevent multiple requests
    _isFetching = true;

    try {
      var response = await newsRepsitory.getNewsById(sourceId, _currentPage);
      if (response != null &&
          response.status != 'error' &&
          response.articles.isNotEmpty) {
        newsList.addAll(response.articles);
        emit(NewsSucessState(newsList: List.from(newsList)));
        _currentPage++; // Increase page count only if new data is received
      }
    } catch (e) {
      print("Error loading more news: $e");
    } finally {
      _isFetching = false;
    }
  }

  void getNewsbySearch(String q) async {
    try {
      emit(NewsLoadingState());
      var response = await newsRepsitory.getNewsBySearch(q);
      if (response == null || response.status == 'error') {
        emit(NewsFailureState(
            errorMessage: response?.message ?? "Unknown error"));
      } else {
        emit(NewsSucessState(newsList: response.articles));
      }
    } catch (e) {
      emit(NewsFailureState(errorMessage: e.toString()));
    }
  }
}
