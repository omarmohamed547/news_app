import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_route/apis/api_constat.dart';
import 'package:news_route/apis/api_endPoints.dart';
import 'package:news_route/models/news_response/news_response.dart';
import 'package:news_route/models/source_response/source_response.dart';

class ApiManager {
  ApiManager._();
  static ApiManager? _instance;
  static getInstance() {
    _instance ??= ApiManager._();
    return _instance;
  }

  Future<SourceResponse?> getSources(String categotyId) async {
    Uri url = Uri.https(ApiConstat.baseUrl, ApiEndpoints.sourceApi,
        {"apiKey": ApiConstat.apiKey, "category": categotyId});
    try {
      var response = await http.get(url);
      return SourceResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }

  Future<NewsResponse?> getNewsById(String sourcId) async {
    Uri url = Uri.https(ApiConstat.baseUrl, ApiEndpoints.newsApi,
        {"apiKey": ApiConstat.apiKey, "sources": sourcId});
    try {
      var response = await http.get(url);
      return NewsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }

  Future<NewsResponse?> getNewsBysearch(String q) async {
    Uri url = Uri.https(ApiConstat.baseUrl, ApiEndpoints.newsApi,
        {"apiKey": ApiConstat.apiKey, "q": q});
    try {
      var response = await http.get(url);
      return NewsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }
}
