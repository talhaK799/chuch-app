class Predicution {
  String? address;
  String? placeId;

  Predicution({this.address, this.placeId});

  Predicution.fromJson(json) {
    this.address = json["description"];
    this.placeId = json["place_id"];
  }

  toJson() {
    return {
      "description": address,
      "place_id": placeId,
    };
  }
}
