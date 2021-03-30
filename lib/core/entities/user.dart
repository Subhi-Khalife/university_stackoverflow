
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
    });

    int id;
    String firstName;
    dynamic middleName;
    String lastName;
    dynamic collageNumber;
    DateTime verifiedAt;
    String email;
    dynamic emailVerifiedAt;
    dynamic profilePic;
    dynamic mobile;
    dynamic facebookUrl;
    dynamic linkedInUrl;
    dynamic suspendedAt;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    int userTypeId;
    int collegeId;
    int universityId;
    String token;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? "null" : json["id"],
        firstName: json["first_name"] == null ? "null" : json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"] == null ? "null" : json["last_name"],
        collageNumber: json["collage_number"],
        verifiedAt: json["verified_at"] == null ? null : DateTime.parse(json["verified_at"]),
        email: json["email"] == null ? "null" : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        profilePic: json["profile_pic"],
        mobile: json["mobile"],
        facebookUrl: json["facebook_url"],
        linkedInUrl: json["linked_in_url"],
        suspendedAt: json["suspended_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        userTypeId: json["user_type_id"] == null ? "null" : json["user_type_id"],
        collegeId: json["college_id"] == null ? "null" : json["college_id"],
        universityId: json["university_id"] == null ? "null" : json["university_id"],
        token: json["token"] == null ? "null" : json["token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? "null" : id,
        "first_name": firstName == null ? "null" : firstName,
        "middle_name": middleName,
        "last_name": lastName == null ? "null" : lastName,
        "collage_number": collageNumber,
        "verified_at": verifiedAt == null ? null : verifiedAt.toIso8601String(),
        "email": email == null ? "null" : email,
        "email_verified_at": emailVerifiedAt,
        "profile_pic": profilePic,
        "mobile": mobile,
        "facebook_url": facebookUrl,
        "linked_in_url": linkedInUrl,
        "suspended_at": suspendedAt,
        "created_at": createdAt == null ?null: createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "user_type_id": userTypeId == null ? "null" : userTypeId,
        "college_id": collegeId == null ? "null" : collegeId,
        "university_id": universityId == null ? "null" : universityId,
        "token": token == null ? "null" : token,
    };
}