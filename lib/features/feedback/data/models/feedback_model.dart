// To parse this JSON data, do
//
//     final feedbackModel = feedbackModelFromJson(jsonString);

import 'dart:convert';

FeedbackModel feedbackModelFromJson(String str) =>
    FeedbackModel.fromJson(json.decode(str));

String feedbackModelToJson(FeedbackModel data) => json.encode(data.toJson());

class FeedbackModel {
  FeedbackModel({
    this.message,
    this.status,
  });

  String message;
  int status;

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        message: json["message"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "Status": status,
      };
}
