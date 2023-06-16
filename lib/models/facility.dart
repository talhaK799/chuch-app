import 'dart:convert';

class Facility {
  final String id;
  final String address;
  final String country;
  final DateTime createdAt;
  final String description;

  Facility({
    required this.id,
    required this.address,
    required this.country,
    required this.createdAt,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'country': country,
      'created_at': createdAt.toIso8601String(),
      'description': description,
    };
  }

  static Facility fromJson(Map<String, dynamic> json) {
    return Facility(
      id: json['id'],
      address: json['address'],
      country: json['country'],
      createdAt: DateTime.parse(json['created_at']),
      description: json['description'],
    );
  }

  String toJson() => json.encode(toMap());
}
