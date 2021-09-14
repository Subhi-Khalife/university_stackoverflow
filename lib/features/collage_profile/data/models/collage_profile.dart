// To parse this JSON data, do
//
//     final collageProfileModel = collageProfileModelFromJson(jsonString);

import 'dart:convert';

import 'package:university/core/entities/collega.dart';
import 'package:university/core/entities/common_question.dart';
import 'package:university/core/entities/user.dart';

CollageProfileModel collageProfileModelFromJson(String str) => CollageProfileModel.fromJson(json.decode(str));

String collageProfileModelToJson(CollageProfileModel data) => json.encode(data.toJson());

class CollageProfileModel {
    CollageProfileModel({
        this.data,
        this.message,
        this.status,
    });

    Data data;
    String message;
    int status;

    factory CollageProfileModel.fromJson(Map<String, dynamic> json) => CollageProfileModel(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
        status: json["Status"] == null ? null : json["Status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
        "Status": status == null ? null : status,
    };
}

class Data {
    Data({
        this.id,
        this.firstName,
        this.middleName,
        this.lastName,
        this.collageNumber,
        this.verifiedAt,
        this.email,
        this.emailVerifiedAt,
        this.profilePic,
        this.mobile,
        this.facebookUrl,
        this.linkedInUrl,
        this.suspendedAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.userTypeId,
        this.collegeId,
        this.universityId,
        this.college,
    });

    int id;
    String firstName;
    String middleName;
    String lastName;
    int collageNumber;
    DateTime verifiedAt;
    String email;
    dynamic emailVerifiedAt;
    String profilePic;
    dynamic mobile;
    String facebookUrl;
    String linkedInUrl;
    dynamic suspendedAt;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    int userTypeId;
    int collegeId;
    int universityId;
    College college;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        middleName: json["middle_name"] == null ? null : json["middle_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        collageNumber: json["collage_number"] == null ? null : json["collage_number"],
        verifiedAt: json["verified_at"] == null ? null : DateTime.parse(json["verified_at"]),
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        profilePic: json["profile_pic"] == null ? null : json["profile_pic"],
        mobile: json["mobile"],
        facebookUrl: json["facebook_url"] == null ? null : json["facebook_url"],
        linkedInUrl: json["linked_in_url"] == null ? null : json["linked_in_url"],
        suspendedAt: json["suspended_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        userTypeId: json["user_type_id"] == null ? null : json["user_type_id"],
        collegeId: json["college_id"] == null ? null : json["college_id"],
        universityId: json["university_id"] == null ? null : json["university_id"],
        college: json["college"] == null ? null : College.fromJson(json["college"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "middle_name": middleName == null ? null : middleName,
        "last_name": lastName == null ? null : lastName,
        "collage_number": collageNumber == null ? null : collageNumber,
        "verified_at": verifiedAt == null ? null : verifiedAt.toIso8601String(),
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt,
        "profile_pic": profilePic == null ? null : profilePic,
        "mobile": mobile,
        "facebook_url": facebookUrl == null ? null : facebookUrl,
        "linked_in_url": linkedInUrl == null ? null : linkedInUrl,
        "suspended_at": suspendedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "user_type_id": userTypeId == null ? null : userTypeId,
        "college_id": collegeId == null ? null : collegeId,
        "university_id": universityId == null ? null : universityId,
        "college": college == null ? null : college.toJson(),
    };
}

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
        subjects: json["subjects"] == null ? null : List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "college_id": collegeId == null ? null : collegeId,
        "subjects": subjects == null ? null : List<dynamic>.from(subjects.map((x) => x.toJson())),
    };
}

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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        yearId: json["year_id"] == null ? null : json["year_id"],
        semesterId: json["semester_id"] == null ? null : json["semester_id"],
        departmentId: json["department_id"] == null ? null : json["department_id"],
        files: json["files"] == null ? null : List<FileElement>.from(json["files"].map((x) => FileElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "year_id": yearId == null ? null : yearId,
        "semester_id": semesterId == null ? null : semesterId,
        "department_id": departmentId == null ? null : departmentId,
        "files": files == null ? null : List<dynamic>.from(files.map((x) => x.toJson())),
    };
}

class FileElement {
    FileElement({
        this.id,
        this.name,
        this.url,
        this.createdAt,
        this.userId,
        this.subjectId,
        this.generationYearId,
    });

    int id;
    String name;
    String url;
    DateTime createdAt;
    dynamic userId;
    int subjectId;
    int generationYearId;

    factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        userId: json["user_id"],
        subjectId: json["subject_id"] == null ? null : json["subject_id"],
        generationYearId: json["generation_year_id"] == null ? null : json["generation_year_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "url": url == null ? null : url,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "user_id": userId,
        "subject_id": subjectId == null ? null : subjectId,
        "generation_year_id": generationYearId == null ? null : generationYearId,
    };
}


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
        entryDate: json["entry_date"] == null ? null : DateTime.parse(json["entry_date"]),
        graduationDate: json["graduation_date"] == null ? null : DateTime.parse(json["graduation_date"]),
        description: json["description"] == null ? null : json["description"],
        site: json["site"],
        studentNum: json["student_num"] == null ? null : json["student_num"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        collegeId: json["college_id"] == null ? null : json["college_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "entry_date": entryDate == null ? null : "${entryDate.year.toString().padLeft(4, '0')}-${entryDate.month.toString().padLeft(2, '0')}-${entryDate.day.toString().padLeft(2, '0')}",
        "graduation_date": graduationDate == null ? null : "${graduationDate.year.toString().padLeft(4, '0')}-${graduationDate.month.toString().padLeft(2, '0')}-${graduationDate.day.toString().padLeft(2, '0')}",
        "description": description == null ? null : description,
        "site": site,
        "student_num": studentNum == null ? null : studentNum,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "college_id": collegeId == null ? null : collegeId,
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
