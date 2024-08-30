// To parse this JSON data, do
//
//     final historyResponse = historyResponseFromJson(jsonString);

import 'dart:convert';

HistoryResponse historyResponseFromJson(String str) =>
    HistoryResponse.fromJson(json.decode(str));

String historyResponseToJson(HistoryResponse data) =>
    json.encode(data.toJson());

class HistoryResponse {
  List<Datum>? data;
  dynamic page;
  int? total;
  int? perPage;
  int? lastPage;
  dynamic nextPage;
  dynamic previousPage;
  int? statusCode;
  String? message;

  HistoryResponse({
    this.data,
    this.page,
    this.total,
    this.perPage,
    this.lastPage,
    this.nextPage,
    this.previousPage,
    this.statusCode,
    this.message,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) =>
      HistoryResponse(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        page: json["page"],
        total: json["total"],
        perPage: json["perPage"],
        lastPage: json["lastPage"],
        nextPage: json["nextPage"],
        previousPage: json["previousPage"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "page": page,
        "total": total,
        "perPage": perPage,
        "lastPage": lastPage,
        "nextPage": nextPage,
        "previousPage": previousPage,
        "statusCode": statusCode,
        "message": message,
      };
}

class Datum {
  String? id;
  String? userId;
  String? statusId;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? noTicket;
  String? maintenanceBy;
  bool? surveyStatus;
  dynamic assignSurveyTo;
  Rejected? rejected;
  User? user;
  List<SegmenElement>? segmens;

  Datum({
    this.id,
    this.userId,
    this.statusId,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.noTicket,
    this.maintenanceBy,
    this.surveyStatus,
    this.assignSurveyTo,
    this.rejected,
    this.user,
    this.segmens,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        statusId: json["status_id"],
        note: json["note"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        noTicket: json["no_ticket"],
        maintenanceBy: json["maintenance_by"],
        surveyStatus: json["survey_status"],
        assignSurveyTo: json["assign_survey_to"],
        rejected: json["rejected"] == null
            ? null
            : Rejected.fromJson(json["rejected"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        segmens: json["segmens"] == null
            ? []
            : List<SegmenElement>.from(
                json["segmens"]!.map((x) => SegmenElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "status_id": statusId,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "no_ticket": noTicket,
        "maintenance_by": maintenanceBy,
        "survey_status": surveyStatus,
        "assign_survey_to": assignSurveyTo,
        "rejected": rejected?.toJson(),
        "user": user?.toJson(),
        "segmens": segmens == null
            ? []
            : List<dynamic>.from(segmens!.map((x) => x.toJson())),
      };
}

class Rejected {
  String? id;
  String? reportId;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;

  Rejected({
    this.id,
    this.reportId,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  factory Rejected.fromJson(Map<String, dynamic> json) => Rejected(
        id: json["id"],
        reportId: json["report_id"],
        note: json["note"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "report_id": reportId,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class SegmenElement {
  String? id;
  String? reportId;
  String? mapStreetSegmenId;
  String? userType;
  String? userLevel;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Photo>? photos;
  SegmenSegmen? segmen;

  SegmenElement({
    this.id,
    this.reportId,
    this.mapStreetSegmenId,
    this.userType,
    this.userLevel,
    this.createdAt,
    this.updatedAt,
    this.photos,
    this.segmen,
  });

  factory SegmenElement.fromJson(Map<String, dynamic> json) => SegmenElement(
        id: json["id"],
        reportId: json["report_id"],
        mapStreetSegmenId: json["map_street_segmen_id"],
        userType: json["user_type"],
        userLevel: json["user_level"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        photos: json["photos"] == null
            ? []
            : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
        segmen: json["segmen"] == null
            ? null
            : SegmenSegmen.fromJson(json["segmen"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "report_id": reportId,
        "map_street_segmen_id": mapStreetSegmenId,
        "user_type": userType,
        "user_level": userLevel,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "photos": photos == null
            ? []
            : List<dynamic>.from(photos!.map((x) => x.toJson())),
        "segmen": segmen?.toJson(),
      };
}

class Photo {
  String? id;
  String? reportSegmenId;
  String? filename;
  String? absPath;
  String? fileDumpId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Photo({
    this.id,
    this.reportSegmenId,
    this.filename,
    this.absPath,
    this.fileDumpId,
    this.createdAt,
    this.updatedAt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        reportSegmenId: json["report_segmen_id"],
        filename: json["filename"],
        absPath: json["abs_path"],
        fileDumpId: json["file_dump_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "report_segmen_id": reportSegmenId,
        "filename": filename,
        "abs_path": absPath,
        "file_dump_id": fileDumpId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class SegmenSegmen {
  String? id;
  String? mapStreetSectionId;
  String? mapStreetId;
  String? name;
  dynamic order;
  String? geojson;
  String? centerPoint;
  double? length;
  DateTime? createdAt;
  dynamic updatedAt;

  SegmenSegmen({
    this.id,
    this.mapStreetSectionId,
    this.mapStreetId,
    this.name,
    this.order,
    this.geojson,
    this.centerPoint,
    this.length,
    this.createdAt,
    this.updatedAt,
  });

  factory SegmenSegmen.fromJson(Map<String, dynamic> json) => SegmenSegmen(
        id: json["id"],
        mapStreetSectionId: json["map_street_section_id"],
        mapStreetId: json["map_street_id"],
        name: json["name"],
        order: json["order"],
        geojson: json["geojson"],
        centerPoint: json["center_point"],
        length: json["length"]?.toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "map_street_section_id": mapStreetSectionId,
        "map_street_id": mapStreetId,
        "name": name,
        "order": order,
        "geojson": geojson,
        "center_point": centerPoint,
        "length": length,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
      };
}

class User {
  String? id;
  String? uroleId;
  dynamic username;
  String? fullname;
  dynamic shortname;
  String? email;
  String? avatar;
  dynamic note;
  bool? status;
  bool? isBan;
  DateTime? lastActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? googleId;
  String? phone;
  String? address;

  User({
    this.id,
    this.uroleId,
    this.username,
    this.fullname,
    this.shortname,
    this.email,
    this.avatar,
    this.note,
    this.status,
    this.isBan,
    this.lastActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.googleId,
    this.phone,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        uroleId: json["urole_id"],
        username: json["username"],
        fullname: json["fullname"],
        shortname: json["shortname"],
        email: json["email"],
        avatar: json["avatar"],
        note: json["note"],
        status: json["status"],
        isBan: json["is_ban"],
        lastActive: json["last_active"] == null
            ? null
            : DateTime.parse(json["last_active"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        googleId: json["google_id"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "urole_id": uroleId,
        "username": username,
        "fullname": fullname,
        "shortname": shortname,
        "email": email,
        "avatar": avatar,
        "note": note,
        "status": status,
        "is_ban": isBan,
        "last_active": lastActive?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "google_id": googleId,
        "phone": phone,
        "address": address,
      };
}
