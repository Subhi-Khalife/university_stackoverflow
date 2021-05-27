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

    factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      firstName: json["first_name"],
      middleName: json["middle_name"],
      lastName: json["last_name"],
      collageNumber: json["collage_number"],
      verifiedAt: DateTime.parse(json["verified_at"]),
      email: json["email"],
      emailVerifiedAt: json["email_verified_at"],
      profilePic: json["profile_pic"],
      mobile: json["mobile"],
      facebookUrl: json["facebook_url"],
      linkedInUrl: json["linked_in_url"],
      suspendedAt: json["suspended_at"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      deletedAt: json["deleted_at"],
      userTypeId: json["user_type_id"],
      collegeId: json["college_id"],
      universityId: json["university_id"],
    );

    Map<String, dynamic> toJson() => {
      "id": id,
      "first_name": firstName,
      "middle_name": middleName,
      "last_name": lastName,
      "collage_number": collageNumber,
      "verified_at": verifiedAt.toIso8601String(),
      "email": email,
      "email_verified_at": emailVerifiedAt,
      "profile_pic": profilePic,
      "mobile": mobile,
      "facebook_url": facebookUrl,
      "linked_in_url": linkedInUrl,
      "suspended_at": suspendedAt,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "deleted_at": deletedAt,
      "user_type_id": userTypeId,
      "college_id": collegeId,
      "university_id": universityId,
    };
}