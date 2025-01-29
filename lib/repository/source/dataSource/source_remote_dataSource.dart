import 'package:news_route/models/source_response/source_response.dart';

//online
abstract class SourceRemoteDatasource {
  Future<SourceResponse?> getSources(String categoryId);
}
