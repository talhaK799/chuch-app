class DeptPublicPosting {
  int id;
  String message;
  String senderName;
  Bulletin bulletin;

  DeptPublicPosting(
      {required this.id,
      required this.message,
      required this.senderName,
      required this.bulletin});

  factory DeptPublicPosting.fromJson(Map<String, dynamic> json) {
    return DeptPublicPosting(
      id: json['id'],
      message: json['message'],
      senderName: json['sender_name'],
      bulletin: Bulletin.fromJson(json['bulletin']),
    );
  }
}

class Bulletin {
  String name;
  String image;
  String subtitle;

  Bulletin({required this.name, required this.image, required this.subtitle});

  factory Bulletin.fromJson(Map<String, dynamic> json) {
    return Bulletin(
      name: json['name'],
      image: json['image'],
      subtitle: json['subtitle'],
    );
  }
}
