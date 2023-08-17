class AddChurch {
  String? name;
  String? image;
  String? country;
  String? territory;
  int? noOfMembers;
  String? adminName;
  String? adminEmail;
  int? adminPhone;
  String? address;

  AddChurch(
      {this.name,
      this.image,
      this.country,
      this.territory,
      this.noOfMembers,
      this.adminName,
      this.adminEmail,
      this.adminPhone,
      this.address});

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "country": country,
        "territory": territory,
        "noOfMembers": noOfMembers,
        "adminName": adminName,
        "adminEmail": adminEmail,
        "adminPhone": adminPhone,
        "address": address
      };

  AddChurch.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    image = json['image'] ?? "";
    country = json['country'] ?? '';
    territory = json['territory'] ?? '';
    noOfMembers = json['noOfMembers'] ?? '';
    adminName = json['adminName'] ?? '';
    adminEmail = json['adminEmail'] ?? '';
    adminPhone = json['adminPhone'] ?? '';
    address = json['address'] ?? '';
  }
}
