// To parse this JSON data, do
//
//     final segmenResponseModel = segmenResponseModelFromJson(jsonString);

import 'dart:convert';

SegmenResponseModel segmenResponseModelFromJson(String str) =>
    SegmenResponseModel.fromJson(json.decode(str));

String segmenResponseModelToJson(SegmenResponseModel data) =>
    json.encode(data.toJson());

class SegmenResponseModel {
  String? id;
  String? mapStreetSectionId;
  String? mapStreetId;
  String? name;
  int? order;
  String? geojson;
  String? createdAt;
  dynamic updatedAt;
  SegmenResponseModelReport? report;

  SegmenResponseModel({
    this.id,
    this.mapStreetSectionId,
    this.mapStreetId,
    this.name,
    this.order,
    this.geojson,
    this.createdAt,
    this.updatedAt,
    this.report,
  });

  factory SegmenResponseModel.fromJson(Map<String, dynamic> json) =>
      SegmenResponseModel(
        id: json["id"],
        mapStreetSectionId: json["map_street_section_id"],
        mapStreetId: json["map_street_id"],
        name: json["name"],
        order: json["order"],
        geojson: json["geojson"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        report: json["report"] == null
            ? null
            : SegmenResponseModelReport.fromJson(json["report"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "map_street_section_id": mapStreetSectionId,
        "map_street_id": mapStreetId,
        "name": name,
        "order": order,
        "geojson": geojson,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "report": report?.toJson(),
      };
}

class SegmenResponseModelReport {
  String? id;
  String? reportId;
  String? mapStreetSegmenId;
  String? userType;
  String? userLevel;
  String? createdAt;
  String? updatedAt;
  ReportReport? report;

  SegmenResponseModelReport({
    this.id,
    this.reportId,
    this.mapStreetSegmenId,
    this.userType,
    this.userLevel,
    this.createdAt,
    this.updatedAt,
    this.report,
  });

  factory SegmenResponseModelReport.fromJson(Map<String, dynamic> json) =>
      SegmenResponseModelReport(
        id: json["id"],
        reportId: json["report_id"],
        mapStreetSegmenId: json["map_street_segmen_id"],
        userType: json["user_type"],
        userLevel: json["user_level"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        report: json["report"] == null
            ? null
            : ReportReport.fromJson(json["report"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "report_id": reportId,
        "map_street_segmen_id": mapStreetSegmenId,
        "user_type": userType,
        "user_level": userLevel,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "report": report?.toJson(),
      };
}

class ReportReport {
  String? id;
  String? userId;
  String? statusId;
  String? note;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? noTicket;

  ReportReport({
    this.id,
    this.userId,
    this.statusId,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.noTicket,
  });

  factory ReportReport.fromJson(Map<String, dynamic> json) => ReportReport(
        id: json["id"],
        userId: json["user_id"],
        statusId: json["status_id"],
        note: json["note"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        noTicket: json["no_ticket"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "status_id": statusId,
        "note": note,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "no_ticket": noTicket,
      };
}
