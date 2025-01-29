import 'package:news_route/models/news_response/news_response.dart';
import 'package:news_route/repository/news/dataSource/news_remote_dataSource.dart';
import 'package:news_route/repository/news/repository/news_repsitory.dart';

class NewsRpositoryImpl implements NewsRepsitory {
  NewsRemoteDatasource newsRemoteDatasource;
  NewsRpositoryImpl({required this.newsRemoteDatasource});
  @override
  Future<NewsResponse?> getNewsById(String sourceId) {
    return newsRemoteDatasource.getNewsById(sourceId);
  }
}
