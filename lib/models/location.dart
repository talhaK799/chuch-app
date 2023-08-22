class CustomLocation {
  double? lat;
  double? lng;

  CustomLocation({this.lat, this.lng});

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };

  CustomLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }
}
