// To parse this JSON data, do
//
//     final geoJsonModel = geoJsonModelFromJson(jsonString);

import 'dart:convert';

GeoJsonModel geoJsonModelFromJson(String str) =>
    GeoJsonModel.fromJson(json.decode(str));

String geoJsonModelToJson(GeoJsonModel data) => json.encode(data.toJson());

class GeoJsonModel {
  String type;
  List<List<double>> coordinates;

  GeoJsonModel({
    required this.type,
    required this.coordinates,
  });

  factory GeoJsonModel.fromJson(Map<String, dynamic> json) => GeoJsonModel(
        type: json["type"],
        coordinates: List<List<double>>.from(json["coordinates"]
            .map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(
            coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
