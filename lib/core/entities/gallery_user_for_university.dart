import 'package:university/core/entities/gallery.dart';
import 'package:university/core/entities/user.dart';

class Galleryuser {
  Galleryuser({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.galleryId,
    this.user,
    this.gallery,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;
  int galleryId;
  User user;
  Gallery gallery;

  factory Galleryuser.fromJson(Map<String, dynamic> json) => Galleryuser(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        userId: json["user_id"] == null ? null : json["user_id"],
        galleryId: json["gallery_id"] == null ? null : json["gallery_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        gallery:
            json["gallery"] == null ? null : Gallery.fromJson(json["gallery"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "user_id": userId == null ? null : userId,
        "gallery_id": galleryId == null ? null : galleryId,
        "user": user == null ? null : user.toJson(),
        "gallery": gallery == null ? null : gallery.toJson(),
      };
}
