// To parse this JSON data, do
//
//     final postDetailModel = postDetailModelFromJson(jsonString);

import 'dart:convert';
import 'package:university/core/entities/post.dart';

PostDetailModel postDetailModelFromJson(String str) => PostDetailModel.fromJson(json.decode(str));

String postDetailModelToJson(PostDetailModel data) => json.encode(data.toJson());

class PostDetailModel {
    PostDetailModel({
        this.status,
        this.data,
    });

    String status;
    Posts data;

    factory PostDetailModel.fromJson(Map<String, dynamic> json) => PostDetailModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Posts.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data.toJson(),
    };
}
