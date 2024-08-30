// To parse this JSON data, do
//
//     final geoPointModel = geoPointModelFromJson(jsonString);

import 'dart:convert';

GeoPointModel geoPointModelFromJson(String str) =>
    GeoPointModel.fromJson(json.decode(str));

String geoPointModelToJson(GeoPointModel data) => json.encode(data.toJson());

class GeoPointModel {
  String? type;
  List<double>? coordinates;

  GeoPointModel({
    this.type,
    this.coordinates,
  });

  factory GeoPointModel.fromJson(Map<String, dynamic> json) => GeoPointModel(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
