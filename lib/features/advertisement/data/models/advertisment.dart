// To parse this JSON data, do
//
//     final advertisementModel = advertisementModelFromJson(jsonString);

import 'dart:convert';

AdvertisementModel advertisementModelFromJson(String str) =>
    AdvertisementModel.fromJson(json.decode(str));

String advertisementModelToJson(AdvertisementModel data) =>
    json.encode(data.toJson());

class AdvertisementModel {
  AdvertisementModel({
    this.status,
    this.data,
  });

  String status;
  List<Ads> data;

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) =>
      AdvertisementModel(
        status: json["status"],
        data: List<Ads>.from(json["data"].map((x) => Ads.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Ads {
  Ads({
    this.id,
    this.imageUrl,
    this.link,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String imageUrl;
  String link;
  DateTime createdAt;
  DateTime updatedAt;

  factory Ads.fromJson(Map<String, dynamic> json) => Ads(
        id: json["id"],
        imageUrl: json["image_url"],
        link: json["link"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "link": link,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
