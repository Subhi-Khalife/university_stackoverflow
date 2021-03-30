import 'package:university/core/entities/subject.dart';

class Department {
  Department({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.collegeId,
    this.subjects,
  });

  int id;
  String name;
  dynamic description;
  dynamic createdAt;
  dynamic updatedAt;
  int collegeId;
  List<Subject> subjects;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        collegeId: json["college_id"] == null ? null : json["college_id"],
        subjects: json["subjects"] == null
            ? null
            : List<Subject>.from(
                json["subjects"].map((x) => Subject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "college_id": collegeId == null ? null : collegeId,
        "subjects": subjects == null
            ? null
            : List<dynamic>.from(subjects.map((x) => x.toJson())),
      };
}
