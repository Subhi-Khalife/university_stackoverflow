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

  factory CommonQuestion.fromJson(Map<String, dynamic> json) => CommonQuestion(
        id: json["id"] == null ? null : json["id"],
        answer: json["answer"] == null ? null : json["answer"],
        question: json["question"] == null ? null : json["question"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        collegeId: json["college_id"] == null ? null : json["college_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "answer": answer == null ? null : answer,
        "question": question == null ? null : question,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "college_id": collegeId == null ? null : collegeId,
      };
}
