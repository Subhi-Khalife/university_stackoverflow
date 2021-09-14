// To parse this JSON data, do
//
//     final tapsModel = tapsModelFromJson(jsonString);

import 'dart:convert';

TapsModel tapsModelFromJson(String str) => TapsModel.fromJson(json.decode(str));

String tapsModelToJson(TapsModel data) => json.encode(data.toJson());

class TapsModel {
    TapsModel({
        this.status,
        this.data,
    });

    String status;
    List<Taps> data;

    factory TapsModel.fromJson(Map<String, dynamic> json) => TapsModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : List<Taps>.from(json["data"].map((x) => Taps.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Taps {
    Taps({
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

    factory Taps.fromJson(Map<String, dynamic> json) => Taps(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"],
        isPublic: json["is_public"] == null ? null : json["is_public"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        universityId: json["university_id"] == null ? null : json["university_id"],
        collegeId: json["college_id"] == null ? null : json["college_id"],
        generationYearId: json["generation_year_id"] == null ? null : json["generation_year_id"],
        specializationId: json["specialization_id"] == null ? null : json["specialization_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "type": type,
        "is_public": isPublic == null ? null : isPublic,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "university_id": universityId == null ? null : universityId,
        "college_id": collegeId == null ? null : collegeId,
        "generation_year_id": generationYearId == null ? null : generationYearId,
        "specialization_id": specializationId == null ? null : specializationId,
    };
}
