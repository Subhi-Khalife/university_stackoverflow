import 'package:university/core/entities/collega.dart';

class University {
  University({
    this.id,
    this.name,
    this.creationDate,
    this.city,
    this.logo,
    this.description,
    this.site,
    this.createdAt,
    this.updatedAt,
    this.colleges,
  });

  int id;
  String name;
  dynamic creationDate;
  String city;
  String logo;
  String description;
  dynamic site;
  DateTime createdAt;
  dynamic updatedAt;
  List<College> colleges;

  factory University.fromJson(Map<String, dynamic> json) => University(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        creationDate: json["creation_date"],
        city: json["city"] == null ? null : json["city"],
        logo: json["logo"] == null ? null : json["logo"],
        description: json["description"] == null ? null : json["description"],
        site: json["site"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        colleges: json["colleges"] == null
            ? null
            : List<College>.from(
                json["colleges"].map((x) => College.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "creation_date": creationDate,
        "city": city == null ? null : city,
        "logo": logo == null ? null : logo,
        "description": description == null ? null : description,
        "site": site,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "colleges": colleges == null
            ? null
            : List<dynamic>.from(colleges.map((x) => x.toJson())),
      };
}
