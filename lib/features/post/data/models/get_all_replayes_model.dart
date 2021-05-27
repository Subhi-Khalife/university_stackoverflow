// To parse this JSON data, do
//
//     final getAllReplayesModel = getAllReplayesModelFromJson(jsonString);

import 'dart:convert';

import 'package:university/core/entities/comment.dart';

GetAllReplayesModel getAllReplayesModelFromJson(String str) => GetAllReplayesModel.fromJson(json.decode(str));

String getAllReplayesModelToJson(GetAllReplayesModel data) => json.encode(data.toJson());

class GetAllReplayesModel {
    GetAllReplayesModel({
        this.status,
        this.data,
    });

    String status;
    List<Comment> data;

    factory GetAllReplayesModel.fromJson(Map<String, dynamic> json) => GetAllReplayesModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}
