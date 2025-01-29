import 'package:news_route/models/source_response/source_response.dart';
import 'package:news_route/repository/source/dataSource/source_remote_dataSource.dart';
import 'package:news_route/repository/source/repository/source_repos.dart';

class SourceRepsImpl implements SourceRepository {
  SourceRemoteDatasource sourceRemoteDatasource;
  SourceRepsImpl({required this.sourceRemoteDatasource});
  @override
  Future<SourceResponse?> getSources(String categoryId) {
    return sourceRemoteDatasource.getSources(categoryId);
  }
}
