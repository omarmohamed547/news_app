import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/repository/news/dataSource/news_local_dataSource-impl.dart';
import 'package:news_route/repository/news/dataSource/news_local_dataSource.dart';
import 'package:news_route/repository/news/dataSource/news_remote_dataSource.dart';
import 'package:news_route/repository/news/dataSource/news_remote_dataSource_impl.dart';
import 'package:news_route/repository/news/repository/news_repsitory.dart';
import 'package:news_route/repository/news/repository/news_rpository_impl.dart';
import 'package:news_route/repository/source/dataSource/source_local_dataSource_impl.dart';
import 'package:news_route/repository/source/dataSource/source_remote_dataSource.dart';
import 'package:news_route/repository/source/dataSource/source_remote_dataSource_impl.dart';
import 'package:news_route/repository/source/repository/source_repos.dart';
import 'package:news_route/repository/source/repository/source_reps_impl.dart';

SourceRepository injectSourceRepos() {
  return SourceRepsImpl(
      sourceLocalDatasource: injectSourceLocaldataSource(),
      sourceRemoteDatasource: injectSourceremotedataSource());
}

SourceLocalDatasourceImpl injectSourceLocaldataSource() {
  return SourceLocalDatasourceImpl();
}

SourceRemoteDatasource injectSourceremotedataSource() {
  return SourceRemoteDatasourceImpl(apiManager: ApiManager.getInstance());
}

NewsRepsitory injectNewsRepos() {
  return NewsRpositoryImpl(
      newsRemoteDatasource: injectNewsRemoteDatasource(),
      newsLocalDatasource: injectNewslocaldataSource());
}

NewsRemoteDatasource injectNewsRemoteDatasource() {
  return NewsRemoteDatasourceImpl(apiManager: ApiManager.getInstance());
}

NewsLocalDatasource injectNewslocaldataSource() {
  return NewsLocalDatasourceImpl();
}
