class Year {
  Year({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.collegeId,
  });

  int id;
  String name;
  dynamic createdAt;
  dynamic updatedAt;
  int collegeId;

  factory Year.fromJson(Map<String, dynamic> json) => Year(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        collegeId: json["college_id"] == null ? null : json["college_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "college_id": collegeId == null ? null : collegeId,
      };
}
