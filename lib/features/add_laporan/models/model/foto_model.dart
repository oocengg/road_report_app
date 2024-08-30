// To parse this JSON data, do
//
//     final fotoModel = fotoModelFromJson(jsonString);

import 'dart:convert';

FotoModel fotoModelFromJson(String str) => FotoModel.fromJson(json.decode(str));

String fotoModelToJson(FotoModel data) => json.encode(data.toJson());

class FotoModel {
  String filename;
  String absPath;
  String fileDumpId;

  FotoModel({
    required this.filename,
    required this.absPath,
    required this.fileDumpId,
  });

  factory FotoModel.fromJson(Map<String, dynamic> json) => FotoModel(
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
