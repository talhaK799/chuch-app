class Departments {
  int? id;
  String? name;
  String? desc;

  Departments({this.id, this.name, this.desc});

  factory Departments.fromJson(Map<String, dynamic> json) => Departments(
        id: json["id"],
        name: json["name"],
        desc: json["desc"],
      );
}
