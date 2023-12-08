// ignore_for_file: non_constant_identifier_names

class Photos {
  String? image_uri;
  String? title;
  String? desc;

Photos({this.image_uri, this.title, this.desc});

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
        image_uri: json["image_uri"],
        title: json["title"],
        desc: json["desc"],
      );
}
