// To parse this JSON data, do
//
//     final react = reactFromJson(jsonString);

import 'dart:convert';

React reactFromJson(String str) => React.fromJson(json.decode(str));

String reactToJson(React data) => json.encode(data.toJson());

class React {
    React({
        this.id,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.postId,
        this.commentId,
        this.userId,
        this.generationUserYearId,
    });

    int id;
    String type;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    int postId;
    dynamic commentId;
    int userId;
    int generationUserYearId;

    factory React.fromJson(Map<String, dynamic> json) => React(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        postId: json["post_id"] == null ? null : json["post_id"],
        commentId: json["comment_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        generationUserYearId: json["generation_user_year_id"] == null ? null : json["generation_user_year_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "post_id": postId == null ? null : postId,
        "comment_id": commentId,
        "user_id": userId == null ? null : userId,
        "generation_user_year_id": generationUserYearId == null ? null : generationUserYearId,
    };
}
