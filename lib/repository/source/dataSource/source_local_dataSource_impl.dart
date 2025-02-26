import 'package:news_route/models/source_response/source_response.dart';
import 'package:news_route/repository/source/dataSource/source_local_dataSource.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SourceLocalDatasourceImpl implements SourceLocalDatasource {
  @override
  Future<SourceResponse?> getSources(String categoryId) async {
    // TODO: implement getSources
    var box = await Hive.openBox("SourceTabs");

    var sourceTab = box.get(categoryId);
    return sourceTab;
  }

  @override
  void saveSource(SourceResponse? sourceResponse, String categoryId) async {
    // TODO: implement saveSource
    var box = await Hive.openBox("SourceTabs");
    await box.put(categoryId, sourceResponse);
    await box.close();
  }
}
