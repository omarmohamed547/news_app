import 'package:news_route/models/news_response/news_response.dart';

abstract class NewsRemoteDatasource {
  Future<NewsResponse?> getNewsById(String sourceId);
}
