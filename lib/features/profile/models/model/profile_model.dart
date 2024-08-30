// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  Data? data;
  int? statusCode;
  String? message;

  UserResponse({
    this.data,
    this.statusCode,
    this.message,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
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
  Role? role;

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
    this.role,
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
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
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
        "role": role?.toJson(),
      };
}

class Role {
  String? id;
  String? code;
  String? name;
  DateTime? createdAt;
  dynamic updatedAt;

  Role({
    this.id,
    this.code,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
      };
}
