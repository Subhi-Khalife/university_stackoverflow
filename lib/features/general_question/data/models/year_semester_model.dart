// To parse this JSON data, do
//
//     final yearSemesterModel = yearSemesterModelFromJson(jsonString);

import 'dart:convert';

YearSemesterModel yearSemesterModelFromJson(String str) => YearSemesterModel.fromJson(json.decode(str));

String yearSemesterModelToJson(YearSemesterModel data) => json.encode(data.toJson());

class YearSemesterModel {
    YearSemesterModel({
        this.status,
        this.data,
    });

    String status;
    List<Datum> data;

    factory YearSemesterModel.fromJson(Map<String, dynamic> json) => YearSemesterModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.name,
        this.description,
        this.createdAt,
        this.yearId,
        this.semesterId,
        this.departmentId,
    });

    int id;
    String name;
    String description;
    DateTime createdAt;
    int yearId;
    int semesterId;
    int departmentId;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        yearId: json["year_id"] == null ? null : json["year_id"],
        semesterId: json["semester_id"] == null ? null : json["semester_id"],
        departmentId: json["department_id"] == null ? null : json["department_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "year_id": yearId == null ? null : yearId,
        "semester_id": semesterId == null ? null : semesterId,
        "department_id": departmentId == null ? null : departmentId,
    };
}
