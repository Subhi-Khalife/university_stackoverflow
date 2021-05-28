
import 'package:university/core/entities/comment.dart';

class Posts {
    Posts({
        this.id,
        this.title,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.tabId,
        this.userId,
        this.generationUserYearId,
        this.ratesSumRate,
        this.comments,
        this.reacts,
    });

    int id;
    String title;
    String description;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    int tabId;
    int userId;
    int generationUserYearId;
    String ratesSumRate;
    List<Comment> comments;
    List<Comment> reacts;

    factory Posts.fromJson(Map<String, dynamic> json) => Posts(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        tabId: json["tab_id"] == null ? null : json["tab_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        generationUserYearId: json["generation_user_year_id"] == null ? null : json["generation_user_year_id"],
        ratesSumRate: json["rates_sum_rate"] == null ? null : json["rates_sum_rate"],
        comments: json["comments"] == null ? null : List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
        reacts: json["reacts"] == null ? null : List<Comment>.from(json["reacts"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "tab_id": tabId == null ? null : tabId,
        "user_id": userId == null ? null : userId,
        "generation_user_year_id": generationUserYearId == null ? null : generationUserYearId,
        "rates_sum_rate": ratesSumRate == null ? null : ratesSumRate,
        "comments": comments == null ? null : List<dynamic>.from(comments.map((x) => x.toJson())),
        "reacts": reacts == null ? null : List<dynamic>.from(reacts.map((x) => x.toJson())),
    };
}
