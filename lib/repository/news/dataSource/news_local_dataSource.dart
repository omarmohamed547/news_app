import 'package:news_route/models/news_response/news_response.dart';

abstract class NewsLocalDatasource {
    Future<NewsResponse?>getNews(String categoryId);
 void saveNews(NewsResponse? newsresponse,String categoryId);

}
