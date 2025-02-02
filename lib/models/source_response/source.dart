import 'package:hive_flutter/hive_flutter.dart';
part 'source.g.dart';

@HiveType(typeId: 2)
class Source extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? url;

  @HiveField(4)
  String? category;

  @HiveField(5)
  String? language;

  @HiveField(6)
  String? country;

  Source({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  });

  factory Source.fromJson(Map<dynamic, dynamic> json) => Source(
        id: json['id'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        url: json['url'] as String?,
        category: json['category'] as String?,
        language: json['language'] as String?,
        country: json['country'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'url': url,
        'category': category,
        'language': language,
        'country': country,
      };
}
