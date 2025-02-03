import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_route/models/news_response/article.dart';
import 'package:news_route/models/source_response/source.dart';
part 'news_response.g.dart';

@HiveType(typeId: 3)
class NewsResponse extends HiveObject {
  NewsResponse(
      {required this.status,
      required this.totalResults,
      required this.articles,
      this.code,
      this.message});
  @HiveField(0)
  final String? status;
  @HiveField(1)
  final int? totalResults;
  @HiveField(2)
  final List<Article> articles;
  @HiveField(3)
  String? code;
  @HiveField(4)
  String? message;

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      code: json["code"],
      message: json["message"],
      status: json["status"],
      totalResults: json["totalResults"],
      articles: json["articles"] == null
          ? []
          : List<Article>.from(
              json["articles"]!.map((x) => Article.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": articles.map((x) => x.toJson()).toList(),
      };
}
