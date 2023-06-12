import 'dart:convert';

List<MemberOfModel> memberOfModelFromJson(String str) =>
    List<MemberOfModel>.from(
        json.decode(str).map((x) => MemberOfModel.fromJson(x)));

String memberOfModelToJson(List<MemberOfModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MemberOfModel {
  MemberOfModel({
    required this.id,
    required this.name,
    required this.logo,
  });

  int id;
  String name;
  String logo;

  factory MemberOfModel.fromJson(Map<String, dynamic> json) => MemberOfModel(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
