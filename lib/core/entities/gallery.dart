
import 'package:university/core/entities/gallery_user_for_university.dart';

class Gallery {
    Gallery({
        this.id,
        this.name,
        this.description,
        this.logo,
        this.createdAt,
        this.updatedAt,
        this.departmentId,
        this.universityCalenderId,
        this.laravelThroughKey,
        this.galleryusers,
    });

    int id;
    String name;
    String description;
    String logo;
    DateTime createdAt;
    DateTime updatedAt;
    int departmentId;
    int universityCalenderId;
    int laravelThroughKey;
    List<Galleryuser> galleryusers;

    factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        logo: json["logo"] == null ? null : json["logo"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        departmentId: json["department_id"] == null ? null : json["department_id"],
        universityCalenderId: json["university_calender_id"] == null ? null : json["university_calender_id"],
        laravelThroughKey: json["laravel_through_key"] == null ? null : json["laravel_through_key"],
        galleryusers: json["galleryusers"] == null ? null : List<Galleryuser>.from(json["galleryusers"].map((x) => Galleryuser.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "logo": logo == null ? null : logo,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "department_id": departmentId == null ? null : departmentId,
        "university_calender_id": universityCalenderId == null ? null : universityCalenderId,
        "laravel_through_key": laravelThroughKey == null ? null : laravelThroughKey,
        "galleryusers": galleryusers == null ? null : List<dynamic>.from(galleryusers.map((x) => x.toJson())),
    };
}
