import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_route/models/news_response/news_response.dart';
import 'package:news_route/repository/news/dataSource/news_local_dataSource.dart';
import 'package:news_route/repository/news/dataSource/news_remote_dataSource.dart';
import 'package:news_route/repository/news/repository/news_repsitory.dart';

class NewsRpositoryImpl implements NewsRepsitory {
  NewsRemoteDatasource newsRemoteDatasource;
  NewsLocalDatasource newsLocalDatasource;
  NewsRpositoryImpl(
      {required this.newsRemoteDatasource, required this.newsLocalDatasource});
  @override
  Future<NewsResponse?> getNewsById(String sourceId) async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
//online
      var newsResponse = await newsRemoteDatasource.getNewsById(sourceId);
      newsLocalDatasource.saveNews(newsResponse, sourceId);
      return newsResponse;
    } else {
      //offline
      var newsResponse = await newsLocalDatasource.getNews(sourceId);
      if (newsResponse == null) {
        throw Exception("Check your internet connection");
      }
      return newsResponse;
    }
  }
}
