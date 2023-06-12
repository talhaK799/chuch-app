import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';

class PhotoGalleryAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future getPhotos(String searchQuery) async {
    String query = """
      query MyQuery {
        photo_gallery(where: {title: {_ilike: "%$searchQuery%"}}) {
          image_uri
          title
          desc
        }
      }
    """;

    var res = await hasura.hasuraQuery(query);
    return res["data"]["photo_gallery"];
  }
}
