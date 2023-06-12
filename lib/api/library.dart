import 'package:churchappenings/models/bible.dart';
import 'package:churchappenings/services/hasura.dart';

class LibraryAPI {
  final HasuraService hasura = HasuraService.to;

  Future fetchBibles() async {
    List<BibleModel> data = [];

    try {
      String query = """
          query MyQuery {
            bible {
              title
              description
              file_uri
              id
              thumbnail_uri
            }
          }
        """;
      var res = await hasura.hasuraQuery(query);

      print(res);
    } catch (e) {
      print(e);
    }

    return data;
  }

  Future fetchSongs() async {
    List<BibleModel> data = [];

    try {
      String query = """
          query MyQuery {
            song {
              title
              description
              file_uri
              id
              thumbnail_uri
            }
          }
        """;
      var res = await hasura.hasuraQuery(query);

      print(res);
    } catch (e) {
      print(e);
    }

    return data;
  }

  Future fetchFAQ() async {
    List<BibleModel> data = [];

    try {
      String query = """
          query MyQuery {
            faq {
              answer
              id
              question
            }
          }
        """;
      var res = await hasura.hasuraQuery(query);

      print(res);
    } catch (e) {
      print(e);
    }

    return data;
  }
}
