// To parse this JSON data, do
//
//     final generalQuestionsModel = generalQuestionsModelFromJson(jsonString);

import 'dart:convert';

import 'package:university/core/entities/comment.dart';
import 'package:university/features/collage_profile/data/models/collage_profile.dart';

GeneralQuestionsModel generalQuestionsModelFromJson(String str) => GeneralQuestionsModel.fromJson(json.decode(str));

String generalQuestionsModelToJson(GeneralQuestionsModel data) => json.encode(data.toJson());

class GeneralQuestionsModel {
    GeneralQuestionsModel({
        this.status,
        this.data,
    });

    String status;
    List<GeneralQuestionsList> data;

    factory GeneralQuestionsModel.fromJson(Map<String, dynamic> json) => GeneralQuestionsModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : List<GeneralQuestionsList>.from(json["data"].map((x) => GeneralQuestionsList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GeneralQuestionsList {
    GeneralQuestionsList({
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
        this.ratesSumRate,
        this.subject,
        this.comments,
        this.reacts,
    });

    int id;
    String title;
    String description;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    int subjectId;
    dynamic tabId;
    int userId;
    int generationUserYearId;
    String ratesSumRate;
    Subject subject;
    List<Comment> comments;
    List<Comment> reacts;

    factory GeneralQuestionsList.fromJson(Map<String, dynamic> json) => GeneralQuestionsList(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        subjectId: json["subject_id"] == null ? null : json["subject_id"],
        tabId: json["tab_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        generationUserYearId: json["generation_user_year_id"] == null ? null : json["generation_user_year_id"],
        ratesSumRate: json["rates_sum_rate"] == null ? null : json["rates_sum_rate"],
        subject: json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        comments: json["comments"] == null ? null : List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
        reacts: json["reacts"] == null ? null : List<Comment>.from(json["reacts"].map((x) => Comment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "subject_id": subjectId == null ? null : subjectId,
        "tab_id": tabId,
        "user_id": userId == null ? null : userId,
        "generation_user_year_id": generationUserYearId == null ? null : generationUserYearId,
        "rates_sum_rate": ratesSumRate == null ? null : ratesSumRate,
        "subject": subject == null ? null : subject.toJson(),
        "comments": comments == null ? null : List<dynamic>.from(comments.map((x) => x.toJson())),
        "reacts": reacts == null ? null : List<dynamic>.from(reacts.map((x) => x.toJson())),
    };
}
