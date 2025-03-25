import 'package:news_route/models/source_response/source_response.dart';
import 'package:news_route/repository/source/dataSource/source_local_dataSource.dart';
import 'package:news_route/repository/source/dataSource/source_remote_dataSource.dart';
import 'package:news_route/repository/source/repository/source_repos.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SourceRepsImpl implements SourceRepository {
  SourceRemoteDatasource sourceRemoteDatasource;
  SourceLocalDatasource sourceLocalDatasource;
  SourceRepsImpl(
      {required this.sourceRemoteDatasource,
      required this.sourceLocalDatasource});
  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
//online
      var sourceResponse = await sourceRemoteDatasource.getSources(categoryId);
      sourceLocalDatasource.saveSource(sourceResponse, categoryId);
      return sourceResponse;
    } else {
      //offline
      var sourceResponse = await sourceLocalDatasource.getSources(categoryId);
      if (sourceResponse == null || sourceResponse.sources!.isEmpty) {
        throw Exception("Check your internet connection");
      }
      return sourceResponse;
    }
  }
}
