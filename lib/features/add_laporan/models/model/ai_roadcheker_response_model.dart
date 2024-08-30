// To parse this JSON data, do
//
//     final aiRoadChecker = aiRoadCheckerFromJson(jsonString);

import 'dart:convert';

AiRoadChecker aiRoadCheckerFromJson(String str) =>
    AiRoadChecker.fromJson(json.decode(str));

String aiRoadCheckerToJson(AiRoadChecker data) => json.encode(data.toJson());

class AiRoadChecker {
  String predictedLabel;

  AiRoadChecker({
    required this.predictedLabel,
  });

  factory AiRoadChecker.fromJson(Map<String, dynamic> json) => AiRoadChecker(
        predictedLabel: json["predicted_label"],
      );

  Map<String, dynamic> toJson() => {
        "predicted_label": predictedLabel,
      };
}
