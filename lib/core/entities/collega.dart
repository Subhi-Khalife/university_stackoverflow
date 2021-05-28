
class College {
    College({
        this.id,
        this.name,
        this.address,
        this.email,
        this.logo,
        this.description,
        this.site,
        this.createdAt,
        this.updatedAt,
        this.universityId,
        this.specializationId,
    });

    int id;
    String name;
    String address;
    String email;
    String logo;
    String description;
    String site;
    DateTime createdAt;
    dynamic updatedAt;
    int universityId;
    int specializationId;

    factory College.fromJson(Map<String, dynamic> json) => College(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        email: json["email"] == null ? null : json["email"],
        logo: json["logo"] == null ? null : json["logo"],
        description: json["description"] == null ? null : json["description"],
        site: json["site"] == null ? null : json["site"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        universityId: json["university_id"] == null ? null : json["university_id"],
        specializationId: json["specialization_id"] == null ? null : json["specialization_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "email": email == null ? null : email,
        "logo": logo == null ? null : logo,
        "description": description == null ? null : description,
        "site": site == null ? null : site,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "university_id": universityId == null ? null : universityId,
        "specialization_id": specializationId == null ? null : specializationId,
    };
}
