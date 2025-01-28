import 'package:flutter/material.dart';
import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/models/news_response/news_response.dart';

class NewsViewModel extends ChangeNotifier {
  //hold data

  List<Article>? newsList;
  String? errorMessage;

  //handle logic

  void getNews(String sourceId) async {
    newsList = null;
    errorMessage = null;
    notifyListeners();

    var response = await ApiManager.getNewsById(sourceId);

    try {
      if (response?.status == 'error') {
        errorMessage = response!.message;
      } else {
        newsList = response!.articles;
      }
    } catch (e) {
      errorMessage = "this error has occured";
    }
    notifyListeners();
  }
}
