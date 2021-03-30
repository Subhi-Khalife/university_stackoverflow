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
  dynamic userId;
  int subjectId;
  int generationYearId;

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        userId: json["user_id"],
        subjectId: json["subject_id"] == null ? null : json["subject_id"],
        generationYearId: json["generation_year_id"] == null
            ? null
            : json["generation_year_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "url": url == null ? null : url,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "user_id": userId,
        "subject_id": subjectId == null ? null : subjectId,
        "generation_year_id":
            generationYearId == null ? null : generationYearId,
      };
}
