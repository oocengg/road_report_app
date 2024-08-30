// To parse this JSON data, do
//
//     final editUserResponse = editUserResponseFromJson(jsonString);

import 'dart:convert';

EditUserResponse editUserResponseFromJson(String str) =>
    EditUserResponse.fromJson(json.decode(str));

String editUserResponseToJson(EditUserResponse data) =>
    json.encode(data.toJson());

class EditUserResponse {
  Data? data;
  int? statusCode;
  String? message;

  EditUserResponse({
    this.data,
    this.statusCode,
    this.message,
  });

  factory EditUserResponse.fromJson(Map<String, dynamic> json) =>
      EditUserResponse(
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
  String? id;
  String? uroleId;
  String? username;
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

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
