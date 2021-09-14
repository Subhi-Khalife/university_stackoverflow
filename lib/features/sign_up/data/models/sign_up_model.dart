// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

import 'package:university/core/entities/user.dart';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel({
    this.user,
  });

  User user;

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      SignUpModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() =>
      {
        "user": user == null ? null : user.toJson(),
      };
}
