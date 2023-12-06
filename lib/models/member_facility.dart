class MemberFacility {
  int? id;
  String? name;
  String? address;

  MemberFacility({this.id, this.name, this.address});

  factory MemberFacility.fromJson(Map<String, dynamic> json) => MemberFacility(
        id: json["id"],
        name: json["name"],
        address: json["address"],
      );
}
