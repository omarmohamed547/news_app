import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_route/models/news_response/news_response.dart';
import 'package:news_route/repository/news/dataSource/news_local_dataSource.dart';

class NewsLocalDatasourceImpl implements NewsLocalDatasource {
  @override
  Future<NewsResponse?> getNews(String categoryId) async {
    var box = await Hive.openBox("News");
    return box.get(categoryId);
  }

  @override
  void saveNews(NewsResponse? newsresponse, String categoryId) async {
    var box = await Hive.openBox("News");
    await box.put(categoryId, newsresponse);
    await box.close();
  }
}
