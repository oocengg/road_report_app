// To parse this JSON data, do
//
//     final segmenDetailLaporan = segmenDetailLaporanFromJson(jsonString);

import 'dart:convert';

SegmenDetailLaporan segmenDetailLaporanFromJson(String str) =>
    SegmenDetailLaporan.fromJson(json.decode(str));

String segmenDetailLaporanToJson(SegmenDetailLaporan data) =>
    json.encode(data.toJson());

class SegmenDetailLaporan {
  String? name;
  String? date;
  String? status;
  String? noTicket;
  String? user;
  String? userLevel;
  String? userType;
  dynamic typeSegmenSystem;
  dynamic levelSegmenSystem;
  dynamic typeSegmenAdmin;
  dynamic levelSegmenAdmin;
  List<Photo>? photos;

  SegmenDetailLaporan({
    this.name,
    this.date,
    this.status,
    this.noTicket,
    this.user,
    this.userLevel,
    this.userType,
    this.typeSegmenSystem,
    this.levelSegmenSystem,
    this.typeSegmenAdmin,
    this.levelSegmenAdmin,
    this.photos,
  });

  factory SegmenDetailLaporan.fromJson(Map<String, dynamic> json) =>
      SegmenDetailLaporan(
        name: json["name"],
        date: json["date"],
        status: json["status"],
        noTicket: json["no_ticket"],
        user: json["user"],
        userLevel: json["user_level"],
        userType: json["user_type"],
        typeSegmenSystem: json["type_segmen_system"],
        levelSegmenSystem: json["level_segmen_system"],
        typeSegmenAdmin: json["type_segmen_admin"],
        levelSegmenAdmin: json["level_segmen_admin"],
        photos: json["photos"] == null
            ? []
            : List<Photo>.from(json["photos"]!.map((x) => Photo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date": date,
        "status": status,
        "no_ticket": noTicket,
        "user": user,
        "user_level": userLevel,
        "user_type": userType,
        "type_segmen_system": typeSegmenSystem,
        "level_segmen_system": levelSegmenSystem,
        "type_segmen_admin": typeSegmenAdmin,
        "level_segmen_admin": levelSegmenAdmin,
        "photos": photos == null
            ? []
            : List<dynamic>.from(photos!.map((x) => x.toJson())),
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
