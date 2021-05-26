// To parse this JSON data, do
//
//     final addSearchModel = addSearchModelFromJson(jsonString);

import 'dart:convert';

AddSearchModel addSearchModelFromJson(String str) =>
    AddSearchModel.fromJson(json.decode(str));

String addSearchModelToJson(AddSearchModel data) => json.encode(data.toJson());

class AddSearchModel {
  AddSearchModel({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory AddSearchModel.fromJson(Map<String, dynamic> json) => AddSearchModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.searchText,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String searchText;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        searchText: json["search_text"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "search_text": searchText,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
