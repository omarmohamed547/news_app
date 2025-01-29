import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/ui/News/cubit/news_state.dart';

class NewsViewModel extends Cubit<NewsState> {
  NewsViewModel() : super(NewsLoadingState());

  void getNews(String sourcId) async {
    try {
      emit(NewsLoadingState());
      var response = await ApiManager.getNewsById(sourcId);
      if (response!.status == 'ereeor') {
        emit(NewsFailureState(errorMessage: response.message!));
      } else {
        emit(NewsSucessState(newsList: response.articles));
      }
    } catch (e) {
      emit(NewsFailureState(errorMessage: e.toString()));
    }
  }
}
