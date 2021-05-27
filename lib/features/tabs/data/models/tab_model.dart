// To parse this JSON data, do
//
//     final tabModel = tabModelFromJson(jsonString);

import 'dart:convert';

TabModel tabModelFromJson(String str) => TabModel.fromJson(json.decode(str));

String tabModelToJson(TabModel data) => json.encode(data.toJson());

class TabModel {
  TabModel({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory TabModel.fromJson(Map<String, dynamic> json) => TabModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.type,
    this.isPublic,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.universityId,
    this.collegeId,
    this.generationYearId,
    this.specializationId,
  });

  int id;
  String name;
  dynamic type;
  bool isPublic;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  int universityId;
  int collegeId;
  int generationYearId;
  int specializationId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        isPublic: json["is_public"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        universityId:
            json["university_id"] == null ? null : json["university_id"],
        collegeId: json["college_id"] == null ? null : json["college_id"],
        generationYearId: json["generation_year_id"] == null
            ? null
            : json["generation_year_id"],
        specializationId: json["specialization_id"] == null
            ? null
            : json["specialization_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "is_public": isPublic,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "university_id": universityId == null ? null : universityId,
        "college_id": collegeId == null ? null : collegeId,
        "generation_year_id":
            generationYearId == null ? null : generationYearId,
        "specialization_id": specializationId == null ? null : specializationId,
      };
}
