import 'package:news_route/models/source_response/source_response.dart';

abstract class SourceLocalDatasource {
  Future<SourceResponse?> getSources(String categoryId);
  void saveSource(SourceResponse? sourceResponse, String categoryId);
}
