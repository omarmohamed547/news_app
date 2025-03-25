import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/models/news_response/news_response.dart';
import 'package:news_route/repository/news/dataSource/news_remote_dataSource.dart';

class NewsRemoteDatasourceImpl implements NewsRemoteDatasource {
  ApiManager apiManager;
  NewsRemoteDatasourceImpl({required this.apiManager});
  @override
  Future<NewsResponse?> getNewsById(String sourceId) async {
    var response = await apiManager.getNewsById(sourceId);
    return response;
  }

  @override
  Future<NewsResponse?> getNewsBySearch(String q) async {
    var response = await apiManager.getNewsBysearch(q);
    return response;
  }
}
