// To parse this JSON data, do
//
//     final universitiesWithColleges = universitiesWithCollegesFromJson(jsonString);

import 'dart:convert';

import 'package:university/core/entities/university.dart';

UniversitiesWithCollegesModel universitiesWithCollegesFromJson(String str) =>
    UniversitiesWithCollegesModel.fromJson(json.decode(str));

String universitiesWithCollegesToJson(UniversitiesWithCollegesModel data) =>
    json.encode(data.toJson());

class UniversitiesWithCollegesModel {
  UniversitiesWithCollegesModel({
    this.data,
    this.message,
    this.status,
  });

  List<University> data;
  String message;
  int status;

  factory UniversitiesWithCollegesModel.fromJson(Map<String, dynamic> json) =>
      UniversitiesWithCollegesModel(
        data: List<University>.from(
            json["data"].map((x) => University.fromJson(x))),
        message: json["message"],
        status: json["Status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "Status": status,
      };
}
