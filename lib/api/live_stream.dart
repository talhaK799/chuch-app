import 'dart:developer';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';

class LiveStreamAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future getLink() async {
    // int? churchId = profileApi.selectedChurchId;
    // log('church id===> $churchId');
    String query = """
      query MyQuery {
  facility_settings(where: {setting_id: {_eq: "live_url"}}) {
    setting_value
    setting_id
  }
}


    """;

    var res = await hasura.hasuraQuery(query);
    print('database Response==> $res');
    return res["data"];
  }
}
