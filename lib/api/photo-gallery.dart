import 'dart:developer';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';

class PhotoGalleryAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future getPhotos() async {
    int? churchId = profileApi.selectedChurchId;
    log('church id===> $churchId');
    String query = """
      query MyQuery {
  photo_gallery(where: {facility_id: {_eq: $churchId}}) {
    image_uri
    desc
    title
  }
}
    """;

    var res = await hasura.hasuraQuery(query);
    print('database ${res.length} Response==> $res');
    return res["data"];
  }
}
