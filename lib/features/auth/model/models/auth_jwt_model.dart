// To parse this JSON data, do
//
//     final authJwtResponse = authJwtResponseFromJson(jsonString);

import 'dart:convert';

AuthJwtResponse authJwtResponseFromJson(String str) =>
    AuthJwtResponse.fromJson(json.decode(str));

String authJwtResponseToJson(AuthJwtResponse data) =>
    json.encode(data.toJson());

class AuthJwtResponse {
  User? user;
  int? iat;
  int? exp;

  AuthJwtResponse({
    this.user,
    this.iat,
    this.exp,
  });

  factory AuthJwtResponse.fromJson(Map<String, dynamic> json) =>
      AuthJwtResponse(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        iat: json["iat"],
        exp: json["exp"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "iat": iat,
        "exp": exp,
      };
}

class User {
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
  dynamic phone;
  dynamic address;
  Role? role;

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
    this.role,
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
