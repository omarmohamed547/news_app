import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/models/source_response/source_response.dart';
import 'package:news_route/repository/source/dataSource/source_remote_dataSource.dart';

class SourceRemoteDatasourceImpl implements SourceRemoteDatasource {
  ApiManager apiManager;
  SourceRemoteDatasourceImpl({required this.apiManager});
  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    var response = await apiManager.getSources(categoryId);
    return response;
  }
}
