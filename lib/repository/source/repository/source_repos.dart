import 'package:news_route/models/source_response/source_response.dart';

abstract class SourceRepository {
  Future<SourceResponse?> getSources(String categoryId);
}
