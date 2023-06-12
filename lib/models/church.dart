import 'dart:convert';

List<ChurchModel> churchFromJson(String str) => List<ChurchModel>.from(
    json.decode(str).map((x) => ChurchModel.fromJson(x)));

class ChurchModel {
  String id;
  String name;
  String address;
  double rating;
  int totalUserRatings;
  String type;
  String imageRef;

  ChurchModel({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.totalUserRatings,
    required this.type,
    required this.imageRef,
  });

  factory ChurchModel.fromJson(Map<String, dynamic> json) => ChurchModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        rating: json["rating"],
        totalUserRatings: json["totalUserRatings"],
        type: json["type"],
        imageRef: json["imageRef"],
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
