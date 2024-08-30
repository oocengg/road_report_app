// To parse this JSON data, do
//
//     final uploadImageResponse = uploadImageResponseFromJson(jsonString);

import 'dart:convert';

UploadImageResponse uploadImageResponseFromJson(String str) =>
    UploadImageResponse.fromJson(json.decode(str));

String uploadImageResponseToJson(UploadImageResponse data) =>
    json.encode(data.toJson());

class UploadImageResponse {
  Data? data;
  int? statusCode;
  String? message;

  UploadImageResponse({
    this.data,
    this.statusCode,
    this.message,
  });

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) =>
      UploadImageResponse(
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
  String? filename;
  String? fileType;
  int? fileSize;
  String? category;
  String? folder;
  String? relPath;
  String? absPath;
  String? uploaderIp;
  bool? uploadStatus;
  bool? linkStatus;
  String? createdAt;
  String? updatedAt;
  String? id;

  Data({
    this.filename,
    this.fileType,
    this.fileSize,
    this.category,
    this.folder,
    this.relPath,
    this.absPath,
    this.uploaderIp,
    this.uploadStatus,
    this.linkStatus,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        filename: json["filename"],
        fileType: json["file_type"],
        fileSize: json["file_size"],
        category: json["category"],
        folder: json["folder"],
        relPath: json["rel_path"],
        absPath: json["abs_path"],
        uploaderIp: json["uploader_ip"],
        uploadStatus: json["upload_status"],
        linkStatus: json["link_status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "file_type": fileType,
        "file_size": fileSize,
        "category": category,
        "folder": folder,
        "rel_path": relPath,
        "abs_path": absPath,
        "uploader_ip": uploaderIp,
        "upload_status": uploadStatus,
        "link_status": linkStatus,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "id": id,
      };
}
