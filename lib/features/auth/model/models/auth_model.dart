// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  Data data;
  int statusCode;
  String message;

  AuthResponse({
    required this.data,
    required this.statusCode,
    required this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        data: Data.fromJson(json["data"]),
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "statusCode": statusCode,
        "message": message,
      };
}

class Data {
  String token;
  String jwtToken;

  Data({
    required this.token,
    required this.jwtToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        jwtToken: json["jwtToken"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "jwtToken": jwtToken,
      };
}
