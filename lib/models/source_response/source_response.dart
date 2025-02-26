import 'package:hive_flutter/hive_flutter.dart';

import 'source.dart';
part 'source_response.g.dart';
@HiveType(typeId: 1)
class SourceResponse extends HiveObject {
  @HiveField(0)
  String? status;
  @HiveField(1)
  List<Source>? sources;
  @HiveField(2)
  String? code;
  @HiveField(3)
  String? message;
  SourceResponse({this.status, this.sources, this.code, this.message});

  factory SourceResponse.fromJson(Map<dynamic, dynamic> json) {
    return SourceResponse(
      code: json["code"],
      message: json["message"],
      status: json['status'] as String?,
      sources: json["sources"] == null
          ? []
          : List<Source>.from(json["sources"]!.map((x) => Source.fromJson(x))),
    );
  }

  Map<dynamic, dynamic> toJson() => {
        'status': status,
        'sources': sources?.map((e) => e.toJson()).toList(),
      };
}
