
import 'package:university/core/entities/common_question.dart';
import 'package:university/core/entities/gallery.dart';
import 'package:university/core/entities/university.dart';
import 'package:university/features/collage_profile/data/models/collage_profile.dart';

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
        this.university,
        this.departments,
        this.generations,
        this.years,
        this.commonQuestions,
        this.galleries,
    });

    int id;
    String name;
    String address;
    String email;
    String logo;
    String description;
    String site;
    DateTime createdAt;
    dynamic updatedAt;
    int universityId;
    int specializationId;
    University university;
    List<Department> departments;
    List<Generation> generations;
    List<Year> years;
    List<CommonQuestion> commonQuestions;
    List<Gallery> galleries;

    factory College.fromJson(Map<String, dynamic> json) => College(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        email: json["email"] == null ? null : json["email"],
        logo: json["logo"] == null ? null : json["logo"],
        description: json["description"] == null ? null : json["description"],
        site: json["site"] == null ? null : json["site"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        universityId: json["university_id"] == null ? null : json["university_id"],
        specializationId: json["specialization_id"] == null ? null : json["specialization_id"],
        university: json["university"] == null ? null : University.fromJson(json["university"]),
        departments: json["departments"] == null ? null : List<Department>.from(json["departments"].map((x) => Department.fromJson(x))),
        generations: json["generations"] == null ? null : List<Generation>.from(json["generations"].map((x) => Generation.fromJson(x))),
        years: json["years"] == null ? null : List<Year>.from(json["years"].map((x) => Year.fromJson(x))),
        commonQuestions: json["common_questions"] == null ? null : List<CommonQuestion>.from(json["common_questions"].map((x) => CommonQuestion.fromJson(x))),
        galleries: json["galleries"] == null ? null : List<Gallery>.from(json["galleries"].map((x) => Gallery.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "email": email == null ? null : email,
        "logo": logo == null ? null : logo,
        "description": description == null ? null : description,
        "site": site == null ? null : site,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt,
        "university_id": universityId == null ? null : universityId,
        "specialization_id": specializationId == null ? null : specializationId,
        "university": university == null ? null : university.toJson(),
        "departments": departments == null ? null : List<dynamic>.from(departments.map((x) => x.toJson())),
        "generations": generations == null ? null : List<dynamic>.from(generations.map((x) => x.toJson())),
        "years": years == null ? null : List<dynamic>.from(years.map((x) => x.toJson())),
        "common_questions": commonQuestions == null ? null : List<dynamic>.from(commonQuestions.map((x) => x.toJson())),
        "galleries": galleries == null ? null : List<dynamic>.from(galleries.map((x) => x.toJson())),
    };
}
