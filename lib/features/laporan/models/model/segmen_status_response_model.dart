// To parse this JSON data, do
//
//     final segmenStatusResponseModel = segmenStatusResponseModelFromJson(jsonString);

import 'dart:convert';

SegmenStatusResponseModel segmenStatusResponseModelFromJson(String str) =>
    SegmenStatusResponseModel.fromJson(json.decode(str));

String segmenStatusResponseModelToJson(SegmenStatusResponseModel data) =>
    json.encode(data.toJson());

class SegmenStatusResponseModel {
  String? id;
  String? mapStreetSectionId;
  String? mapStreetId;
  String? name;
  int? order;
  String? geojson;
  String? createdAt;
  dynamic updatedAt;
  SegmenStatusResponseModelReport? report;

  SegmenStatusResponseModel({
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

  factory SegmenStatusResponseModel.fromJson(Map<String, dynamic> json) =>
      SegmenStatusResponseModel(
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
            : SegmenStatusResponseModelReport.fromJson(json["report"]),
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

class SegmenStatusResponseModelReport {
  String? id;
  String? reportId;
  String? mapStreetSegmenId;
  String? userType;
  String? userLevel;
  String? createdAt;
  String? updatedAt;
  AnalyticData? analyticData;
  ReportReport? report;

  SegmenStatusResponseModelReport({
    this.id,
    this.reportId,
    this.mapStreetSegmenId,
    this.userType,
    this.userLevel,
    this.createdAt,
    this.updatedAt,
    this.analyticData,
    this.report,
  });

  factory SegmenStatusResponseModelReport.fromJson(Map<String, dynamic> json) =>
      SegmenStatusResponseModelReport(
        id: json["id"],
        reportId: json["report_id"],
        mapStreetSegmenId: json["map_street_segmen_id"],
        userType: json["user_type"],
        userLevel: json["user_level"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        analyticData: json["analytic_data"] == null
            ? null
            : AnalyticData.fromJson(json["analytic_data"]),
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
        "analytic_data": analyticData?.toJson(),
        "report": report?.toJson(),
      };
}

class AnalyticData {
  String? id;
  String? reportSegmenId;
  String? typeSegmenSystem;
  String? levelSegmenSystem;
  dynamic typeSegmenAdmin;
  dynamic levelSegmenAdmin;
  int? confidence;
  String? createdAt;
  dynamic updatedAt;

  AnalyticData({
    this.id,
    this.reportSegmenId,
    this.typeSegmenSystem,
    this.levelSegmenSystem,
    this.typeSegmenAdmin,
    this.levelSegmenAdmin,
    this.confidence,
    this.createdAt,
    this.updatedAt,
  });

  factory AnalyticData.fromJson(Map<String, dynamic> json) => AnalyticData(
        id: json["id"],
        reportSegmenId: json["report_segmen_id"],
        typeSegmenSystem: json["type_segmen_system"],
        levelSegmenSystem: json["level_segmen_system"],
        typeSegmenAdmin: json["type_segmen_admin"],
        levelSegmenAdmin: json["level_segmen_admin"],
        confidence: json["confidence"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "report_segmen_id": reportSegmenId,
        "type_segmen_system": typeSegmenSystem,
        "level_segmen_system": levelSegmenSystem,
        "type_segmen_admin": typeSegmenAdmin,
        "level_segmen_admin": levelSegmenAdmin,
        "confidence": confidence,
        "created_at": createdAt,
        "updated_at": updatedAt,
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
