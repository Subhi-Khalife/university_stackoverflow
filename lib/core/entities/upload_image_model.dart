// To parse this JSON data, do
//
//     final uploadImageModel = uploadImageModelFromJson(jsonString);

import 'dart:convert';

UploadImageModel uploadImageModelFromJson(String str) => UploadImageModel.fromJson(json.decode(str));

String uploadImageModelToJson(UploadImageModel data) => json.encode(data.toJson());

class UploadImageModel {
    UploadImageModel({
        this.status,
        this.data,
    });

    String status;
    String data;

    factory UploadImageModel.fromJson(Map<String, dynamic> json) => UploadImageModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data,
    };
}
