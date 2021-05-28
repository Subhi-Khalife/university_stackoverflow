// To parse this JSON data, do
//
//     final addCommentResponse = addCommentResponseFromJson(jsonString);

import 'dart:convert';

import 'package:university/core/entities/comment.dart';

AddCommentResponse addCommentResponseFromJson(String str) => AddCommentResponse.fromJson(json.decode(str));

String addCommentResponseToJson(AddCommentResponse data) => json.encode(data.toJson());

class AddCommentResponse {
    AddCommentResponse({
        this.status,
        this.data,
    });

    String status;
    Comment data;

    factory AddCommentResponse.fromJson(Map<String, dynamic> json) => AddCommentResponse(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Comment.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data.toJson(),
    };
}
