import 'dart:convert';

List<ChurchModel> churchFromJson(String str) => List<ChurchModel>.from(
    json.decode(str).map((x) => ChurchModel.fromJson(x)));

class ChurchModel {
  String id;

  String name;
  String address;
  double? rating;
  int? totalUserRatings;
  String? type;
  String? imageRef;
  String? country;
  DateTime? createdAt;
  String? description;
  int? churchId;

  ChurchModel({
    required this.id,
    required this.name,
    required this.address,
    this.rating,
    this.totalUserRatings,
    this.type,
    this.imageRef,
    this.country,
    this.createdAt,
    this.description,
    this.churchId,
  });

  factory ChurchModel.fromJson(Map<String, dynamic> json) => ChurchModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        rating: json["rating"],
        totalUserRatings: json["totalUserRatings"],
        type: json["type"],
        imageRef: json["imageRef"],
        country: json["country"],
        // createdAt: DateTime.parse(json['created_at']),
        description: json["description"],
      );

  factory ChurchModel.fromSearchChurchJson(Map<String, dynamic> json) =>
      ChurchModel(
        churchId: json["id"],
        name: json["name"],
        address: json["address"],
        country: json["country"],
        createdAt: DateTime.parse(json['created_at']),
        description: json["description"],
        id: "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "rating": rating,
        "totalUserRatings": totalUserRatings,
        "type": type,
        "imageRef": imageRef
      };
}
