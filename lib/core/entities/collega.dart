
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
    dynamic address;
    dynamic email;
    dynamic logo;
    dynamic description;
    dynamic site;
    dynamic createdAt;
    dynamic updatedAt;
    int universityId;
    int specializationId;

    factory College.fromJson(Map<String, dynamic> json) => College(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        email: json["email"],
        logo: json["logo"],
        description: json["description"],
        site: json["site"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        universityId: json["university_id"],
        specializationId: json["specialization_id"] == null ? null : json["specialization_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "email": email,
        "logo": logo,
        "description": description,
        "site": site,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "university_id": universityId,
        "specialization_id": specializationId == null ? null : specializationId,
    };
}
