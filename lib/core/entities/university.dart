import 'collega.dart';

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
  dynamic city;
  dynamic logo;
  dynamic description;
  dynamic site;
  dynamic createdAt;
  dynamic updatedAt;
  List<College> colleges;

  factory University.fromJson(Map<String, dynamic> json) => University(
        id: json["id"],
        name: json["name"],
        creationDate: json["creation_date"],
        city: json["city"],
        logo: json["logo"],
        description: json["description"],
        site: json["site"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        colleges: List<College>.from(
            json["colleges"].map((x) => College.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "creation_date": creationDate,
        "city": city,
        "logo": logo,
        "description": description,
        "site": site,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "colleges": List<dynamic>.from(colleges.map((x) => x.toJson())),
      };
}
