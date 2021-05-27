// To parse this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.status,
    this.data,
  });

  String status;
  List<Search> data;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        status: json["status"],
        data: List<Search>.from(json["data"].map((x) => Search.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Search {
  Search({
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

  factory Search.fromJson(Map<String, dynamic> json) => Search(
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
