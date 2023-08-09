class Dept {
  int? id;
  String? name;
  bool? isSelect;
  Dept({this.id, this.name, this.isSelect});
  factory Dept.fromJson(Map<String, dynamic> json) => Dept(
        id: json["id"],
        name: json["name"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
