class MapAddress {
  double? latitude;
  double? longnitude;
  String? address;

  MapAddress({this.address, this.latitude, this.longnitude});

  MapAddress.fromJson(json) {
    // this.address = json["geometry"]["location"]["lat"];
    this.latitude = json["geometry"]["location"]["lat"].toDouble();
    this.longnitude = json["geometry"]["location"]["lng"].toDouble();
  }
}
