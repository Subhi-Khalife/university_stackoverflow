import 'file:///D:/Programming/Flutter/university2/lib/features/collage_profile/data/models/file_element.dart';

class Subject {
  Subject({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.yearId,
    this.semesterId,
    this.departmentId,
    this.files,
  });

  int id;
  String name;
  String description;
  DateTime createdAt;
  int yearId;
  int semesterId;
  int departmentId;
  List<FileElement> files;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        yearId: json["year_id"] == null ? null : json["year_id"],
        semesterId: json["semester_id"] == null ? null : json["semester_id"],
        departmentId:
            json["department_id"] == null ? null : json["department_id"],
        files: json["files"] == null
            ? null
            : List<FileElement>.from(
                json["files"].map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "year_id": yearId == null ? null : yearId,
        "semester_id": semesterId == null ? null : semesterId,
        "department_id": departmentId == null ? null : departmentId,
        "files": files == null
            ? null
            : List<dynamic>.from(files.map((x) => x.toJson())),
      };
}
