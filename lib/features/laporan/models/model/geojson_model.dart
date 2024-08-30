class GeoJsonFeatureCollection {
  List<GeoJsonFeature> features;

  GeoJsonFeatureCollection({required this.features});

  factory GeoJsonFeatureCollection.fromJson(Map<String, dynamic> json) {
    var featureList = json['features'] as List;
    List<GeoJsonFeature> features =
        featureList.map((e) => GeoJsonFeature.fromJson(e)).toList();
    return GeoJsonFeatureCollection(features: features);
  }
}

class GeoJsonFeature {
  int id;
  String type;
  GeoJsonGeometry geometry;
  GeoJsonProperties properties;

  GeoJsonFeature(
      {required this.id,
      required this.type,
      required this.geometry,
      required this.properties});

  factory GeoJsonFeature.fromJson(Map<String, dynamic> json) {
    return GeoJsonFeature(
      id: json['id'] as int,
      type: json['type'] as String,
      geometry: GeoJsonGeometry.fromJson(json['geometry']),
      properties: GeoJsonProperties.fromJson(json['properties']),
    );
  }
}

class GeoJsonGeometry {
  String type;
  List<List<double>> coordinates;

  GeoJsonGeometry({required this.type, required this.coordinates});

  factory GeoJsonGeometry.fromJson(Map<String, dynamic> json) {
    var coordList = json['coordinates'] as List;
    List<List<double>> coordinates = coordList
        .map((e) => List<double>.from(e.map((coord) => coord.toDouble())))
        .toList();
    return GeoJsonGeometry(
        type: json['type'] as String, coordinates: coordinates);
  }
}

class GeoJsonProperties {
  Way way;
  dynamic name;
  int osmId;
  dynamic status;

  GeoJsonProperties({
    required this.way,
    this.name,
    required this.osmId,
    this.status,
  });

  factory GeoJsonProperties.fromJson(Map<String, dynamic> json) =>
      GeoJsonProperties(
        way: Way.fromJson(json["way"]),
        name: json["name"],
        osmId: json["osm_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "way": way.toJson(),
        "name": name,
        "osm_id": osmId,
        "status": status,
      };
}

class Way {
  Crs crs;
  String type;
  List<List<double>> coordinates;

  Way({
    required this.crs,
    required this.type,
    required this.coordinates,
  });

  factory Way.fromJson(Map<String, dynamic> json) => Way(
        crs: Crs.fromJson(json["crs"]),
        type: json["type"],
        coordinates: List<List<double>>.from(json["coordinates"]
            .map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
      );

  Map<String, dynamic> toJson() => {
        "crs": crs.toJson(),
        "type": type,
        "coordinates": List<dynamic>.from(
            coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class Crs {
  String type;
  Properties properties;

  Crs({
    required this.type,
    required this.properties,
  });

  factory Crs.fromJson(Map<String, dynamic> json) => Crs(
        type: json["type"],
        properties: Properties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties.toJson(),
      };
}

class Properties {
  String name;

  Properties({
    required this.name,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
