import 'dart:convert';

import 'package:churchappenings/models/location.dart';

class AddChurch {
  String? name;
  String? logo;
  String? country;
  String? territory;
  String? placeId;
  String? mode;
  String? planData;
  CustomLocation? location;
  int? noOfMembers;
  String? adminName;
  String? adminEmail;
  int? adminPhone;
  String? address;
  String? division;

  AddChurch(
      {this.name,
      this.logo,
      this.country,
      this.territory,
      this.placeId,
      this.planData,
      this.mode,
      this.location,
      this.noOfMembers,
      this.adminName,
      this.adminEmail,
      this.adminPhone,
      this.division,
      this.address});

  Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
        "country": country,
        "territory": territory,
        "placeId": placeId,
        "planData": planData,
        "mode": mode,
        "location": location?.toJson(),
        "noOfMembers": noOfMembers,
        "adminName": adminName,
        "adminEmail": adminEmail,
        "adminPhone": adminPhone,
        "address": address,
        "division": division
      };

  AddChurch.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    logo = json['logo'] ?? "";
    country = json['country'] ?? '';
    territory = json['territory'] ?? '';
    noOfMembers = json['noOfMembers'] ?? 0;
    placeId = json['placeId'] ?? '';
    planData = json['planData'] ?? '';
    mode = json['mode'] ?? '';
    location = json['location'] != null
        ? CustomLocation.fromJson(jsonDecode(json['location']))
        : null;
    adminName = json['adminName'] ?? '';
    adminEmail = json['adminEmail'] ?? '';
    adminPhone = json['adminPhone'] ?? '';
    address = json['address'] ?? '';
    division = json['division'] ?? '';
  }
}
