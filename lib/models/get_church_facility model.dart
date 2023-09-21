class Facility {

   String? name;
   int? id;

  Facility({ this.name,  this.id});

  factory Facility.fromJson(Map<String, dynamic> json) {
    return Facility(
      name: json['name'] ,
      id: json['id'] ,
    );
  }
}
