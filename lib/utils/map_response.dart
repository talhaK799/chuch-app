import 'package:churchappenings/models/address.dart';

class MapResponse {
  MapAddress? mapAddress;

  MapResponse(success, {error});

  MapResponse.fromJson(json) {
    if (json['result'] != null) {
      if (json['result'] != null) {
        this.mapAddress = MapAddress.fromJson(json['result']);
      }
    }
  }
}
