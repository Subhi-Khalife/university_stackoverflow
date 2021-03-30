// To parse this JSON data, do
//
//     final commonQuestionModel = commonQuestionModelFromJson(jsonString);

import 'dart:convert';

import 'package:university/core/entities/common_question.dart';

CommonQuestionModel commonQuestionModelFromJson(String str) =>
    CommonQuestionModel.fromJson(json.decode(str));

String commonQuestionModelToJson(CommonQuestionModel data) =>
    json.encode(data.toJson());

class CommonQuestionModel {
  CommonQuestionModel({
    this.data,
    this.message,
    this.status,
  });

  List<CommonQuestion> data;
  String message;
  int status;

  factory CommonQuestionModel.fromJson(Map<String, dynamic> json) =>
      CommonQuestionModel(
        data: json["data"] == null
            ? null
            : List<CommonQuestion>.from(
                json["data"].map((x) => CommonQuestion.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message == null ? null : message,
        "status": status == null ? null : status,
      };
}
