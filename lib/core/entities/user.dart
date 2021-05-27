import 'package:university/core/entities/collega.dart';
import 'package:university/core/entities/post.dart';
import 'package:university/core/entities/search.dart';
import 'package:university/core/entities/university.dart';

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
        this.posts,
        this.searchs,
    });

    int id;
    String firstName;
    dynamic middleName;
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
    List<Posts> posts;
    List<Search> searchs;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        middleName: json["middle_name"],
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
        posts: json["posts"] == null ? null : List<Posts>.from(json["posts"].map((x) => Posts.fromJson(x))),
        searchs: json["searchs"] == null ? null : List<Search>.from(json["searchs"].map((x) => Search.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "middle_name": middleName,
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
        "posts": posts == null ? null : List<dynamic>.from(posts.map((x) => x.toJson())),
        "searchs": searchs == null ? null : List<dynamic>.from(searchs.map((x) => x.toJson())),
    };
}
