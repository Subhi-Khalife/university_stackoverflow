import 'user.dart';

class PostInfo {
  PostInfo({
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
    this.postId,
    this.commentId,
    this.user,
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
  dynamic ratesSumRate;
  List<PostInfo> comments;
  List<React> reacts;
  int postId;
  dynamic commentId;
  User user;

  factory PostInfo.fromJson(Map<String, dynamic> json) => PostInfo(
        id: json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        tabId: json["tab_id"] == null ? null : json["tab_id"],
        userId: json["user_id"],
        generationUserYearId: json["generation_user_year_id"],
        ratesSumRate: json["rates_sum_rate"],
        comments: List<PostInfo>.from(
            json["comments"].map((x) => PostInfo.fromJson(x))),
        reacts: List<React>.from(json["reacts"].map((x) => React.fromJson(x))),
        postId: json["post_id"] == null ? null : json["post_id"],
        commentId: json["comment_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title == null ? null : title,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "tab_id": tabId == null ? null : tabId,
        "user_id": userId,
        "generation_user_year_id": generationUserYearId,
        "rates_sum_rate": ratesSumRate,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "reacts": List<dynamic>.from(reacts.map((x) => x.toJson())),
        "post_id": postId == null ? null : postId,
        "comment_id": commentId,
        "user": user == null ? null : user.toJson(),
      };
}

class React {
  React({
    this.id,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.postId,
    this.commentId,
    this.generationUserYearId,
    this.userId,
    this.user,
  });

  int id;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int postId;
  dynamic commentId;
  int generationUserYearId;
  int userId;
  User user;

  factory React.fromJson(Map<String, dynamic> json) => React(
        id: json["id"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        postId: json["post_id"],
        commentId: json["comment_id"],
        generationUserYearId: json["generation_user_year_id"],
        userId: json["user_id"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "post_id": postId,
        "comment_id": commentId,
        "generation_user_year_id": generationUserYearId,
        "user_id": userId,
        "user": user.toJson(),
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String url;
  dynamic label;
  bool active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}
