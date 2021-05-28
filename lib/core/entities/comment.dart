
import 'package:university/core/entities/user.dart';

class Comment {
    Comment({
        this.id,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.postId,
        this.userId,
        this.generationUserYearId,
        this.commentId,
        this.ratesSumRate,
        this.reacts,
        this.user,
        this.comments,
        this.type,
        this.deletedAt,
    });

    int id;
    String description;
    DateTime createdAt;
    DateTime updatedAt;
    int postId;
    int userId;
    int generationUserYearId;
    int commentId;
    String ratesSumRate;
    List<Comment> reacts;
    User user;
    List<Comment> comments;
    String type;
    dynamic deletedAt;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"] == null ? null : json["id"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        postId: json["post_id"] == null ? null : json["post_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        generationUserYearId: json["generation_user_year_id"] == null ? null : json["generation_user_year_id"],
        commentId: json["comment_id"] == null ? null : json["comment_id"],
        ratesSumRate: json["rates_sum_rate"] == null ? null : json["rates_sum_rate"],
        reacts: json["reacts"] == null ? null : List<Comment>.from(json["reacts"].map((x) => Comment.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        comments: json["comments"] == null ? null : List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
        type: json["type"] == null ? null : json["type"],
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "description": description == null ? null : description,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "post_id": postId == null ? null : postId,
        "user_id": userId == null ? null : userId,
        "generation_user_year_id": generationUserYearId == null ? null : generationUserYearId,
        "comment_id": commentId == null ? null : commentId,
        "rates_sum_rate": ratesSumRate == null ? null : ratesSumRate,
        "reacts": reacts == null ? null : List<dynamic>.from(reacts.map((x) => x.toJson())),
        "user": user == null ? null : user.toJson(),
        "comments": comments == null ? null : List<dynamic>.from(comments.map((x) => x.toJson())),
        "type": type == null ? null : type,
        "deleted_at": deletedAt,
    };
}

