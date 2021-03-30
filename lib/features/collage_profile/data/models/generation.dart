class Generation {
  Generation({
    this.id,
    this.name,
    this.entryDate,
    this.graduationDate,
    this.description,
    this.site,
    this.studentNum,
    this.createdAt,
    this.updatedAt,
    this.collegeId,
  });

  int id;
  String name;
  DateTime entryDate;
  DateTime graduationDate;
  String description;
  dynamic site;
  String studentNum;
  DateTime createdAt;
  DateTime updatedAt;
  int collegeId;

  factory Generation.fromJson(Map<String, dynamic> json) => Generation(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        entryDate: json["entry_date"] == null
            ? null
            : DateTime.parse(json["entry_date"]),
        graduationDate: json["graduation_date"] == null
            ? null
            : DateTime.parse(json["graduation_date"]),
        description: json["description"] == null ? null : json["description"],
        site: json["site"],
        studentNum: json["student_num"] == null ? null : json["student_num"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        collegeId: json["college_id"] == null ? null : json["college_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "entry_date": entryDate == null
            ? null
            : "${entryDate.year.toString().padLeft(4, '0')}-${entryDate.month.toString().padLeft(2, '0')}-${entryDate.day.toString().padLeft(2, '0')}",
        "graduation_date": graduationDate == null
            ? null
            : "${graduationDate.year.toString().padLeft(4, '0')}-${graduationDate.month.toString().padLeft(2, '0')}-${graduationDate.day.toString().padLeft(2, '0')}",
        "description": description == null ? null : description,
        "site": site,
        "student_num": studentNum == null ? null : studentNum,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "college_id": collegeId == null ? null : collegeId,
      };
}
