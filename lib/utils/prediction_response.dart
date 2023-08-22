import 'package:churchappenings/models/prediction.dart';

class PrdicutionResponse {
  List<Predicution> predicutions = [];

  // PrdicutionResponse(success, {error});

  PrdicutionResponse.fromJson(json) {
    print("pred++ ==>${json['predictions'].toString()}");
    if (json['predictions'] != null) {
      json['predictions'].forEach((location) {
        this.predicutions.add(Predicution.fromJson(location));
      });
      for (var i = 0; i < predicutions.length; i++) {
        print("Address======> ${predicutions[i].toJson()} <=====");
      }
    }
  }
}
