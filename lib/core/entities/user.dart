class User {
    User({
      this.email,
        this.firstName,
        this.lastName,
        this.mobile,
        this.collegeId,
        this.universityId,
      this.collageNumber,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.userTypeId,
        this.token,
    });

    String email;
    String firstName;
    String lastName;
    String mobile;
    int collegeId;
    int universityId;
    int collageNumber;
    DateTime updatedAt;
    DateTime createdAt;
    int id;
    int userTypeId;
    String token;

    factory User.fromJson(Map<String, dynamic> json) => User(
      email: json["email"] == null ?null : json["email"],
      firstName: json["first_name"] == null ?null : json["first_name"],
      lastName: json["last_name"] == null ?null : json["last_name"],
      mobile: json["mobile"] == null ?null : json["mobile"],
      collegeId: json["college_id"] == null ?null : json["college_id"],
      universityId: json["university_id"] == null ?null : json["university_id"],
      collageNumber: json["collage_number"] == null
          ?null
          : json["collage_number"],
      updatedAt: json["updated_at"] == null ?null : DateTime.parse(
          json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      id: json["id"] == null ?null : json["id"],
      userTypeId: json["user_type_id"] == null ?null : json["user_type_id"],
      token: json["token"] == null ?null : json["token"],
    );

    Map<String, dynamic> toJson() => {
      "email": email == null ?null : email,
      "first_name": firstName == null ?null : firstName,
      "last_name": lastName == null ?null : lastName,
      "mobile": mobile == null ?null : mobile,
      "college_id": collegeId == null ?null : collegeId,
      "university_id": universityId == null ?null : universityId,
      "collage_number": collageNumber == null ?null : collageNumber,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      "created_at": createdAt == null ?null : createdAt.toIso8601String(),
      "id": id == null ?null : id,
      "user_type_id": userTypeId == null ?null : userTypeId,
      "token": token == null ?null : token,
    };
}