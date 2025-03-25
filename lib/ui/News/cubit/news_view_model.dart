import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/repository/news/dataSource/news_remote_dataSource.dart';
import 'package:news_route/repository/news/dataSource/news_remote_dataSource_impl.dart';
import 'package:news_route/repository/news/repository/news_repsitory.dart';
import 'package:news_route/repository/news/repository/news_rpository_impl.dart';
import 'package:news_route/ui/News/cubit/news_state.dart';

class NewsViewModel extends Cubit<NewsState> {
  NewsRepsitory newsRepsitory;
  NewsViewModel({required this.newsRepsitory}) : super(NewsLoadingState());

  void getNews(String sourcId) async {
    try {
      emit(NewsLoadingState());
      var response = await newsRepsitory.getNewsById(sourcId);
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
