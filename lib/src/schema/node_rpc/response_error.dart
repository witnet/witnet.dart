// To parse this JSON data, do
//
//     final responseError = responseErrorFromJson(jsonString);

import 'dart:convert';

class ResponseError {
  ResponseError({
    required this.code,
    required this.message,
  });

  final int code;
  final String message;

  factory ResponseError.fromRawJson(String str) => ResponseError.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseError.fromJson(Map<String, dynamic> json) => ResponseError(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}
