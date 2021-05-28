
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
