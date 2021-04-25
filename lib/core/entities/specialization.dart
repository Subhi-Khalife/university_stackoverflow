
class Specialization {
    Specialization({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.specializationTypeId,
    });

    int id;
    String name;
    dynamic createdAt;
    dynamic updatedAt;
    int specializationTypeId;

    factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        specializationTypeId: json["specialization_type_id"] == null ? null : json["specialization_type_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "specialization_type_id": specializationTypeId == null ? null : specializationTypeId,
    };
}
