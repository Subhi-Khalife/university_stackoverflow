// To parse this JSON data, do
//
//     final collageProfileModel = collageProfileModelFromJson(jsonString);

import 'dart:convert';

CollageProfileModel collageProfileModelFromJson(String str) =>
    CollageProfileModel.fromJson(json.decode(str));

String collageProfileModelToJson(CollageProfileModel data) =>
    json.encode(data.toJson());

class CollageProfileModel {
  CollageProfileModel({
    this.data,
    this.message,
    this.status,
  });

  Data data;
  String message;
  int status;

  factory CollageProfileModel.fromJson(Map<String, dynamic> json) =>
      CollageProfileModel(
        data: json["data"] == null ?null : Data.fromJson(json["data"]),
        message: json["message"] == null ?null : json["message"],
        status: json["Status"] == null ?null : json["Status"],
      );

  Map<String, dynamic> toJson() => {
    "data": data == null ?null : data.toJson(),
    "message": message == null ?null : message,
    "Status": status == null ?null : status,
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
  DateTime emailVerifiedAt;
  String profilePic;
  String mobile;
  String facebookUrl;
  String linkedInUrl;
  DateTime suspendedAt;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime deletedAt;
  int userTypeId;
  int collegeId;
  int universityId;
  College college;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ?null : json["id"],
    firstName: json["first_name"] == null ?null : json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"] == null ?null : json["last_name"],
    collageNumber: json["collage_number"],
    verifiedAt: json["verified_at"] == null ?null : DateTime.parse(
        json["verified_at"]),
    email: json["email"] == null ?null : json["email"],
    emailVerifiedAt: json["email_verified_at"],
    profilePic: json["profile_pic"],
    mobile: json["mobile"],
    facebookUrl: json["facebook_url"],
    linkedInUrl: json["linked_in_url"],
    suspendedAt: json["suspended_at"],
    createdAt: json["created_at"] == null ?null : DateTime.parse(
        json["created_at"]),
    updatedAt: json["updated_at"] == null ?null : DateTime.parse(
        json["updated_at"]),
    deletedAt: json["deleted_at"],
    userTypeId: json["user_type_id"] == null ?null : json["user_type_id"],
    collegeId: json["college_id"] == null ?null : json["college_id"],
    universityId: json["university_id"] == null ?null : json["university_id"],
    college: json["college"] == null ?null : College.fromJson(json["college"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ?null : id,
    "first_name": firstName == null ?null : firstName,
    "middle_name": middleName,
    "last_name": lastName == null ?null : lastName,
    "collage_number": collageNumber,
    "verified_at": verifiedAt == null ?null : verifiedAt.toIso8601String(),
    "email": email == null ?null : email,
    "email_verified_at": emailVerifiedAt,
    "profile_pic": profilePic,
    "mobile": mobile,
    "facebook_url": facebookUrl,
    "linked_in_url": linkedInUrl,
    "suspended_at": suspendedAt,
    "created_at": createdAt == null ?null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ?null : updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "user_type_id": userTypeId == null ?null : userTypeId,
    "college_id": collegeId == null ?null : collegeId,
    "university_id": universityId == null ?null : universityId,
    "college": college == null ?null : college.toJson(),
  };
}

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
  });

  int id;
  String name;
  String address;
  String email;
  dynamic logo;
  String description;
  DateTime site;
  DateTime createdAt;
  DateTime updatedAt;
  int universityId;
  int specializationId;
  University university;
  List<Department> departments;
  List<Generation> generations;
  List<Year> years;
  List<CommonQuestion> commonQuestions;

  factory College.fromJson(Map<String, dynamic> json) =>
      College(
        id: json["id"] == null ?null : json["id"],
        name: json["name"] == null ?null : json["name"],
        address: json["address"],
        email: json["email"],
        logo: json["logo"],
        description: json["description"],
        site: json["site"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        universityId: json["university_id"] == null
            ?null
            : json["university_id"],
        specializationId: json["specialization_id"] == null
            ?null
            : json["specialization_id"],
        university: json["university"] == null ?null : University.fromJson(
            json["university"]),
        departments: json["departments"] == null ?null : List<Department>.from(
            json["departments"].map((x) => Department.fromJson(x))),
        generations: json["generations"] == null ?null : List<Generation>.from(
            json["generations"].map((x) => Generation.fromJson(x))),
        years: json["years"] == null ?null : List<Year>.from(
            json["years"].map((x) => Year.fromJson(x))),
        commonQuestions: json["common_questions"] == null ?null : List<
            CommonQuestion>.from(
            json["common_questions"].map((x) => CommonQuestion.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id == null ?null : id,
        "name": name == null ?null : name,
        "address": address,
        "email": email,
        "logo": logo,
        "description": description,
        "site": site,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "university_id": universityId == null ?null : universityId,
        "specialization_id": specializationId == null ?null : specializationId,
        "university": university == null ?null : university.toJson(),
        "departments": departments == null ?null : List<dynamic>.from(
            departments.map((x) => x.toJson())),
        "generations": generations == null ?null : List<dynamic>.from(
            generations.map((x) => x.toJson())),
        "years": years == null ?null : List<dynamic>.from(
            years.map((x) => x.toJson())),
        "common_questions": commonQuestions == null ?null : List<dynamic>.from(
            commonQuestions.map((x) => x.toJson())),
      };
}

class CommonQuestion {
  CommonQuestion({
    this.id,
    this.answer,
    this.question,
    this.createdAt,
    this.updatedAt,
    this.collegeId,
  });

  int id;
  String answer;
  String question;
  DateTime createdAt;
  DateTime updatedAt;
  int collegeId;

  factory CommonQuestion.fromJson(Map<String, dynamic> json) =>
      CommonQuestion(
        id: json["id"] == null ?null : json["id"],
        answer: json["answer"] == null ?null : json["answer"],
        question: json["question"] == null ?null : json["question"],
        createdAt: json["created_at"] == null ?null : DateTime.parse(
            json["created_at"]),
        updatedAt: json["updated_at"] == null ?null : DateTime.parse(
            json["updated_at"]),
        collegeId: json["college_id"] == null ?null : json["college_id"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id == null ?null : id,
        "answer": answer == null ?null : answer,
        "question": question == null ?null : question,
        "created_at": createdAt == null ?null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ?null : updatedAt.toIso8601String(),
        "college_id": collegeId == null ?null : collegeId,
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
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  int collegeId;
  List<Subject> subjects;

  factory Department.fromJson(Map<String, dynamic> json) =>
      Department(
        id: json["id"] == null ?null : json["id"],
        name: json["name"] == null ?null : json["name"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        collegeId: json["college_id"] == null ?null : json["college_id"],
        subjects: json["subjects"] == null ?null : List<Subject>.from(
            json["subjects"].map((x) => Subject.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id == null ?null : id,
        "name": name == null ?null : name,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "college_id": collegeId == null ?null : collegeId,
        "subjects": subjects == null ?null : List<dynamic>.from(
            subjects.map((x) => x.toJson())),
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

  factory Subject.fromJson(Map<String, dynamic> json) =>
      Subject(
        id: json["id"] == null ?null : json["id"],
        name: json["name"] == null ?null : json["name"],
        description: json["description"] == null ?null : json["description"],
        createdAt: json["created_at"] == null ?null : DateTime.parse(
            json["created_at"]),
        yearId: json["year_id"] == null ?null : json["year_id"],
        semesterId: json["semester_id"] == null ?null : json["semester_id"],
        departmentId: json["department_id"] == null
            ?null
            : json["department_id"],
        files: json["files"] == null ?null : List<FileElement>.from(
            json["files"].map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id == null ?null : id,
        "name": name == null ?null : name,
        "description": description == null ?null : description,
        "created_at": createdAt == null ?null : createdAt.toIso8601String(),
        "year_id": yearId == null ?null : yearId,
        "semester_id": semesterId == null ?null : semesterId,
        "department_id": departmentId == null ?null : departmentId,
        "files": files == null ?null : List<dynamic>.from(
            files.map((x) => x.toJson())),
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
  int userId;
  int subjectId;
  int generationYearId;

  factory FileElement.fromJson(Map<String, dynamic> json) =>
      FileElement(
        id: json["id"] == null ?null : json["id"],
        name: json["name"] == null ?null : json["name"],
        url: json["url"] == null ?null : json["url"],
        createdAt: json["created_at"] == null ?null : DateTime.parse(
            json["created_at"]),
        userId: json["user_id"],
        subjectId: json["subject_id"] == null ?null : json["subject_id"],
        generationYearId: json["generation_year_id"] == null
            ?null
            : json["generation_year_id"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id == null ?null : id,
        "name": name == null ?null : name,
        "url": url == null ?null : url,
        "created_at": createdAt == null ?null : createdAt.toIso8601String(),
        "user_id": userId,
        "subject_id": subjectId == null ?null : subjectId,
        "generation_year_id": generationYearId == null ?null : generationYearId,
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

  factory Generation.fromJson(Map<String, dynamic> json) =>
      Generation(
        id: json["id"] == null ?null : json["id"],
        name: json["name"] == null ?null : json["name"],
        entryDate: json["entry_date"] == null ?null : DateTime.parse(
            json["entry_date"]),
        graduationDate: json["graduation_date"] == null ?null : DateTime.parse(
            json["graduation_date"]),
        description: json["description"] == null ?null : json["description"],
        site: json["site"],
        studentNum: json["student_num"] == null ?null : json["student_num"],
        createdAt: json["created_at"] == null ?null : DateTime.parse(
            json["created_at"]),
        updatedAt: json["updated_at"] == null ?null : DateTime.parse(
            json["updated_at"]),
        collegeId: json["college_id"] == null ?null : json["college_id"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id == null ?null : id,
        "name": name == null ?null : name,
        "entry_date": entryDate == null ?null : "${entryDate.year.toString()
            .padLeft(4, '0')}-${entryDate.month.toString().padLeft(
            2, '0')}-${entryDate.day.toString().padLeft(2, '0')}",
        "graduation_date": graduationDate == null ?null : "${graduationDate.year
            .toString().padLeft(4, '0')}-${graduationDate.month.toString()
            .padLeft(2, '0')}-${graduationDate.day.toString().padLeft(2, '0')}",
        "description": description == null ?null : description,
        "site": site,
        "student_num": studentNum == null ?null : studentNum,
        "created_at": createdAt == null ?null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ?null : updatedAt.toIso8601String(),
        "college_id": collegeId == null ?null : collegeId,
      };
}

class University {
  University({
    this.id,
    this.name,
    this.creationDate,
    this.city,
    this.logo,
    this.description,
    this.site,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  DateTime creationDate;
  String city;
  dynamic logo;
  String description;
  dynamic site;
  DateTime createdAt;
  DateTime updatedAt;

  factory University.fromJson(Map<String, dynamic> json) =>
      University(
        id: json["id"] == null ?null : json["id"],
        name: json["name"] == null ?null : json["name"],
        creationDate: json["creation_date"],
        city: json["city"],
        logo: json["logo"],
        description: json["description"],
        site: json["site"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id == null ?null : id,
        "name": name == null ?null : name,
        "creation_date": creationDate,
        "city": city,
        "logo": logo,
        "description": description,
        "site": site,
        "created_at": createdAt,
        "updated_at": updatedAt,
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

  factory Year.fromJson(Map<String, dynamic> json) =>
      Year(
        id: json["id"] == null ?null : json["id"],
        name: json["name"] == null ?null : json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        collegeId: json["college_id"] == null ?null : json["college_id"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id == null ?null : id,
        "name": name == null ?null : name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "college_id": collegeId == null ?null : collegeId,
      };
}
