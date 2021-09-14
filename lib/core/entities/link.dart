
class Link {
    Link({
        this.url,
        this.label,
        this.active,
    });

    String url;
    dynamic label;
    bool active;

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"] == null ? null : json["url"],
        label: json["label"],
        active: json["active"] == null ? null : json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "label": label,
        "active": active == null ? null : active,
    };
}
