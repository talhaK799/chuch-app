import 'dart:convert';

List<Member> memberOfModelFromJson(String str) =>
    List<Member>.from(json.decode(str).map((x) => Member.fromJson(x)));

String memberOfModelToJson(List<Member> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Member {
  Member({
    required this.id,
    required this.name,
    required this.logo,
  });

  int id;
  String name;
  String logo;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"] != null ? json["id"] : null,
        name: json["name"] != null ? json["name"] : "",
        logo: json["logo"] != null ? json["logo"] : "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
