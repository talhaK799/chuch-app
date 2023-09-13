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


// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class Departments {
//   int? id;
//   int? facility_id;

//   String? name;
//   String? desc;

//   Departments({
//     this.id,
//     this.facility_id,
//     this.name,
//     this.desc,
//   });

//   factory Departments.fromJson(Map<String, dynamic> json) => Departments(
//         id: json["id"],
//         facility_id:  json["facility_id"],
//         name: json["name"],
//         desc: json["desc"],
//       );
// }

