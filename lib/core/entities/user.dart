// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:university/core/entities/collega.dart';
import 'package:university/core/entities/gallery_user_for_university.dart';
import 'package:university/core/entities/university.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
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
        this.token,
        this.college,
        this.university,
        this.galleryUsers,
        this.posts,
        this.searchs,
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
    String token;
    College college;
    University university;
    List<Galleryuser> galleryUsers;
    List<Post> posts;
    List<Search> searchs;

    factory User.fromJson(Map<String, dynamic> json) => User(
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
        token: json["token"] == null ? null : json["token"],
        college: json["college"] == null ? null : College.fromJson(json["college"]),
        university: json["university"] == null ? null : University.fromJson(json["university"]),
        galleryUsers: json["gallery_users"] == null ? null : List<Galleryuser>.from(json["gallery_users"].map((x) => Galleryuser.fromJson(x))),
        posts: json["posts"] == null ? null : List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        searchs: json["searchs"] == null ? null : List<Search>.from(json["searchs"].map((x) => Search.fromJson(x))),
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
        "token": token == null ? null : token,
        "college": college == null ? null : college.toJson(),
        "university": university == null ? null : university.toJson(),
        "gallery_users": galleryUsers == null ? null : List<dynamic>.from(galleryUsers.map((x) => x.toJson())),
        "posts": posts == null ? null : List<dynamic>.from(posts.map((x) => x.toJson())),
        "searchs": searchs == null ? null : List<dynamic>.from(searchs.map((x) => x.toJson())),
    };
}

class Post {
    Post({
        this.id,
        this.title,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.subjectId,
        this.tabId,
        this.userId,
        this.generationUserYearId,
    });

    int id;
    String title;
    String description;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    int subjectId;
    int tabId;
    int userId;
    int generationUserYearId;

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        subjectId: json["subject_id"] == null ? null : json["subject_id"],
        tabId: json["tab_id"] == null ? null : json["tab_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        generationUserYearId: json["generation_user_year_id"] == null ? null : json["generation_user_year_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "subject_id": subjectId == null ? null : subjectId,
        "tab_id": tabId == null ? null : tabId,
        "user_id": userId == null ? null : userId,
        "generation_user_year_id": generationUserYearId == null ? null : generationUserYearId,
    };
}
class Search {
    Search({
        this.id,
        this.userId,
        this.searchText,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int userId;
    String searchText;
    DateTime createdAt;
    DateTime updatedAt;

    factory Search.fromJson(Map<String, dynamic> json) => Search(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        searchText: json["search_text"] == null ? null : json["search_text"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "search_text": searchText == null ? null : searchText,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
