// To parse this JSON data, do
//
//     final delSearchModel = delSearchModelFromJson(jsonString);

import 'dart:convert';

DelSearchModel delSearchModelFromJson(String str) =>
    DelSearchModel.fromJson(json.decode(str));

String delSearchModelToJson(DelSearchModel data) => json.encode(data.toJson());

class DelSearchModel {
  DelSearchModel({
    this.message,
    this.status,
  });

  String message;
  int status;

  factory DelSearchModel.fromJson(Map<String, dynamic> json) => DelSearchModel(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
