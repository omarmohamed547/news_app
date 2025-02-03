import 'package:news_route/models/news_response/article.dart';

abstract class NewsState {}

class NewsLoadingState extends NewsState {}

class NewsFailureState extends NewsState {
  String errorMessage;
  NewsFailureState({required this.errorMessage});
}

class NewsSucessState extends NewsState {
  List<Article> newsList;
  NewsSucessState({required this.newsList});
}
