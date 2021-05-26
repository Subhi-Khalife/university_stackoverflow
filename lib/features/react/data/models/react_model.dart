// To parse this JSON data, do
//
//     final reactModel = reactModelFromJson(jsonString);

import 'dart:convert';

ReactModel reactModelFromJson(String str) =>
    ReactModel.fromJson(json.decode(str));

String reactModelToJson(ReactModel data) => json.encode(data.toJson());

class ReactModel {
  ReactModel({
    this.status,
    this.msg,
  });

  String status;
  String msg;

  factory ReactModel.fromJson(Map<String, dynamic> json) => ReactModel(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
