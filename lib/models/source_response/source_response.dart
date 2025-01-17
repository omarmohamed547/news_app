import 'source.dart';

class SourceResponse {
  String? status;
  List<Source>? sources;
  String? code;
  String? message;
  SourceResponse({this.status, this.sources, this.code, this.message});

  factory SourceResponse.fromJson(Map<String, dynamic> json) {
    return SourceResponse(
      code: json["code"],
      message: json["message"],
      status: json['status'] as String?,
      sources: json["sources"] == null
          ? []
          : List<Source>.from(json["sources"]!.map((x) => Source.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'sources': sources?.map((e) => e.toJson()).toList(),
      };
}
