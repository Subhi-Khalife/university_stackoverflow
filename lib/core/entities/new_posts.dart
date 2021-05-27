// To parse this JSON data, do
//
//     final newPosts = newPostsFromJson(jsonString);

import 'dart:convert';

NewPosts newPostsFromJson(String str) => NewPosts.fromJson(json.decode(str));

String newPostsToJson(NewPosts data) => json.encode(data.toJson());

class NewPosts {
    NewPosts({
        this.status,
        this.data,
    });

    String status;
    Data data;

    factory NewPosts.fromJson(Map<String, dynamic> json) => NewPosts(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        this.title,
        this.description,
        this.tabId,
        this.generationUserYearId,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    String title;
    String description;
    int tabId;
    int generationUserYearId;
    int userId;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        tabId: json["tab_id"] == null ? null : json["tab_id"],
        generationUserYearId: json["generation_user_year_id"] == null ? null : json["generation_user_year_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "tab_id": tabId == null ? null : tabId,
        "generation_user_year_id": generationUserYearId == null ? null : generationUserYearId,
        "user_id": userId == null ? null : userId,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "id": id == null ? null : id,
    };
}
