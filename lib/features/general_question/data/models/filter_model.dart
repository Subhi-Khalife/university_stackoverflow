// To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

import 'dart:convert';

FilterModel filterModelFromJson(String str) => FilterModel.fromJson(json.decode(str));

String filterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  FilterModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.semesters,
    this.years,
  });

  List<Semester> semesters;
  List<Year> years;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        semesters: json["semesters"] == null
            ? null
            : List<Semester>.from(json["semesters"].map((x) => Semester.fromJson(x))),
        years: json["years"] == null
            ? null
            : List<Year>.from(json["years"].map((x) => Year.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "semesters":
            semesters == null ? null : List<dynamic>.from(semesters.map((x) => x.toJson())),
        "years": years == null ? null : List<dynamic>.from(years.map((x) => x.toJson())),
      };
}

class Semester {
  Semester({
    this.id,
    this.semester,
    this.createdAt,
    this.updatedAt,
    this.universityId,
  });

  int id;
  String semester;
  dynamic createdAt;
  dynamic updatedAt;
  int universityId;

  factory Semester.fromJson(Map<String, dynamic> json) => Semester(
        id: json["id"] == null ? null : json["id"],
        semester: json["semester"] == null ? null : json["semester"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        universityId: json["university_id"] == null ? null : json["university_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "semester": semester == null ? null : semester,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "university_id": universityId == null ? null : universityId,
      };
}

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
