import 'dart:convert';

List<Church> churchFromJson(String str) =>
    List<Church>.from(json.decode(str).map((x) => Church.fromJson(x)));

class Church {
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

  Church({
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

  factory Church.fromJson(Map<String, dynamic> json) => Church(
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

  factory Church.fromSearchChurchJson(Map<String, dynamic> json) => Church(
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
