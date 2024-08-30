// To parse this JSON data, do
//
//     final historyDetailResponse = historyDetailResponseFromJson(jsonString);

import 'dart:convert';

HistoryDetailResponse historyDetailResponseFromJson(String str) =>
    HistoryDetailResponse.fromJson(json.decode(str));

String historyDetailResponseToJson(HistoryDetailResponse data) =>
    json.encode(data.toJson());

class HistoryDetailResponse {
  List<Datum>? data;
  int? page;
  int? total;
  int? perPage;
  int? lastPage;
  dynamic nextPage;
  dynamic previousPage;
  int? statusCode;
  String? message;

  HistoryDetailResponse({
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

  factory HistoryDetailResponse.fromJson(Map<String, dynamic> json) =>
      HistoryDetailResponse(
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
  String? assignSurveyTo;
  DateTime? surveyStartDate;
  DateTime? surveyEndDate;
  Rating? rating;
  Rejected? rejected;
  User? user;
  List<SegmenElement>? segmens;
  Schedule? schedule;

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
    this.surveyStartDate,
    this.surveyEndDate,
    this.rating,
    this.rejected,
    this.user,
    this.segmens,
    this.schedule,
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
        surveyStartDate: json["survey_start_date"] == null
            ? null
            : DateTime.parse(json["survey_start_date"]),
        surveyEndDate: json["survey_end_date"] == null
            ? null
            : DateTime.parse(json["survey_end_date"]),
        rating: json["rating"] == null ? null : Rating.fromJson(json["rating"]),
        rejected: json["rejected"] == null
            ? null
            : Rejected.fromJson(json["rejected"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        segmens: json["segmens"] == null
            ? []
            : List<SegmenElement>.from(
                json["segmens"]!.map((x) => SegmenElement.fromJson(x))),
        schedule: json["schedule"] == null
            ? null
            : Schedule.fromJson(json["schedule"]),
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
        "survey_start_date": surveyStartDate?.toIso8601String(),
        "survey_end_date": surveyEndDate?.toIso8601String(),
        "rating": rating?.toJson(),
        "rejected": rejected?.toJson(),
        "user": user?.toJson(),
        "segmens": segmens == null
            ? []
            : List<dynamic>.from(segmens!.map((x) => x.toJson())),
        "schedule": schedule?.toJson(),
      };
}

class Rating {
  String? id;
  String? reportId;
  int? rate;
  String? comment;
  DateTime? createdAt;
  DateTime? updatedAt;

  Rating({
    this.id,
    this.reportId,
    this.rate,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"],
        reportId: json["report_id"],
        rate: json["rate"],
        comment: json["comment"],
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
        "rate": rate,
        "comment": comment,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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

class Schedule {
  String? id;
  String? reportId;
  dynamic status;
  dynamic note;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  DateTime? dateEnd;
  DateTime? dateStart;
  List<Maintenanced>? maintenanced;

  Schedule({
    this.id,
    this.reportId,
    this.status,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.dateEnd,
    this.dateStart,
    this.maintenanced,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        reportId: json["report_id"],
        status: json["status"],
        note: json["note"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        dateEnd:
            json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
        dateStart: json["date_start"] == null
            ? null
            : DateTime.parse(json["date_start"]),
        maintenanced: json["maintenanced"] == null
            ? []
            : List<Maintenanced>.from(
                json["maintenanced"]!.map((x) => Maintenanced.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "report_id": reportId,
        "status": status,
        "note": note,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "date_end": dateEnd?.toIso8601String(),
        "date_start": dateStart?.toIso8601String(),
        "maintenanced": maintenanced == null
            ? []
            : List<dynamic>.from(maintenanced!.map((x) => x.toJson())),
      };
}

class Maintenanced {
  String? id;
  String? reportScheduleId;
  String? segmenId;
  DateTime? date;
  String? note;
  List<Photo>? photoBefore;
  List<PhotoAfter>? photoAfter;
  DateTime? createdAt;
  DateTime? updatedAt;

  Maintenanced({
    this.id,
    this.reportScheduleId,
    this.segmenId,
    this.date,
    this.note,
    this.photoBefore,
    this.photoAfter,
    this.createdAt,
    this.updatedAt,
  });

  factory Maintenanced.fromJson(Map<String, dynamic> json) => Maintenanced(
        id: json["id"],
        reportScheduleId: json["report_schedule_id"],
        segmenId: json["segmen_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        note: json["note"],
        photoBefore: json["photo_before"] == null
            ? []
            : List<Photo>.from(
                json["photo_before"]!.map((x) => Photo.fromJson(x))),
        photoAfter: json["photo_after"] == null
            ? []
            : List<PhotoAfter>.from(
                json["photo_after"]!.map((x) => PhotoAfter.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "report_schedule_id": reportScheduleId,
        "segmen_id": segmenId,
        "date": date?.toIso8601String(),
        "note": note,
        "photo_before": photoBefore == null
            ? []
            : List<dynamic>.from(photoBefore!.map((x) => x.toJson())),
        "photo_after": photoAfter == null
            ? []
            : List<dynamic>.from(photoAfter!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class PhotoAfter {
  String? filename;
  String? absPath;
  String? fileDumpId;

  PhotoAfter({
    this.filename,
    this.absPath,
    this.fileDumpId,
  });

  factory PhotoAfter.fromJson(Map<String, dynamic> json) => PhotoAfter(
        filename: json["filename"],
        absPath: json["abs_path"],
        fileDumpId: json["file_dump_id"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "abs_path": absPath,
        "file_dump_id": fileDumpId,
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

class SegmenElement {
  String? id;
  String? reportId;
  String? mapStreetSegmenId;
  String? userType;
  String? userLevel;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic analyticData;
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
    this.analyticData,
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
        analyticData: json["analytic_data"],
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
        "analytic_data": analyticData,
        "photos": photos == null
            ? []
            : List<dynamic>.from(photos!.map((x) => x.toJson())),
        "segmen": segmen?.toJson(),
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
