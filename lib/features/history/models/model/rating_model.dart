// To parse this JSON data, do
//
//     final ratingResponse = ratingResponseFromJson(jsonString);

import 'dart:convert';

RatingResponse ratingResponseFromJson(String str) =>
    RatingResponse.fromJson(json.decode(str));

String ratingResponseToJson(RatingResponse data) => json.encode(data.toJson());

class RatingResponse {
  Data? data;
  int? statusCode;
  String? message;

  RatingResponse({
    this.data,
    this.statusCode,
    this.message,
  });

  factory RatingResponse.fromJson(Map<String, dynamic> json) => RatingResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "statusCode": statusCode,
        "message": message,
      };
}

class Data {
  String? reportId;
  int? rate;
  dynamic comment;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.reportId,
    this.rate,
    this.comment,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        reportId: json["report_id"],
        rate: json["rate"],
        comment: json["comment"],
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "report_id": reportId,
        "rate": rate,
        "comment": comment,
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
