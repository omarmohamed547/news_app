import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_route/apis/api_constat.dart';
import 'package:news_route/apis/api_endPoints.dart';
import 'package:news_route/models/source_response/source_response.dart';

class ApiManager {
  static Future<SourceResponse?> getSources() async {
    Uri url = Uri.https(ApiConstat.baseUrl, ApiEndpoints.sourceApi,
        {"apiKey": ApiConstat.apiKey});
    try {
      var response = await http.get(url);
      return SourceResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }
}
