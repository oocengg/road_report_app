// To parse this JSON data, do
//
//     final faqResponseModel = faqResponseModelFromJson(jsonString);

import 'dart:convert';

FaqResponseModel faqResponseModelFromJson(String str) =>
    FaqResponseModel.fromJson(json.decode(str));

String faqResponseModelToJson(FaqResponseModel data) =>
    json.encode(data.toJson());

class FaqResponseModel {
  String? id;
  String? title;
  String? desc;
  int? order;
  String? createdAt;
  String? updatedAt;

  FaqResponseModel({
    this.id,
    this.title,
    this.desc,
    this.order,
    this.createdAt,
    this.updatedAt,
  });

  factory FaqResponseModel.fromJson(Map<String, dynamic> json) =>
      FaqResponseModel(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        order: json["order"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "order": order,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
