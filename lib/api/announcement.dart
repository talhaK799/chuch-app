import 'dart:convert';
import 'package:churchappenings/services/hasura.dart';
import 'package:get/get.dart';
import 'profile.dart';

class AnnouncementAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future<dynamic> getAnnouncemnts() async {
    String query =
        """
      query MyQuery(\$id: Int!) {
        announcement(where: {facility_id: {_eq: \$id}}) {
          title
          type
          id
          description
          date_time
        }
      }
    """;
    

    Map<String, dynamic> variables = {
      "id": profileApi.selectedChurchId,
    };
    var res = await hasura.hasuraQuery(query, variables);
    return res["data"]["announcement"];
  }

  Future createAnnouncement({
    required String title,
    required String description,
    required DateTime dateTime,
    required String type,
  }) async {
    String mutation =
        """
      mutation MyMutation(\$date_time: timestamp!, \$description: String!, \$facility_id: Int!, \$title: String!, \$type: announcement_type_enum!) {
        insert_announcement_one(object: {date_time: \$date_time, description: \$description, facility_id: \$facility_id, title: \$title, type: \$type}) {
          title
        }
      }
    """;

    Map<String, dynamic> variables = {
      "date_time": json.encode(dateTime, toEncodable: myEncode),
      "description": description,
      "facility_id": profileApi.selectedChurchId,
      "title": title,
      "type": type
    };

    var res = await hasura.hasuraMutation(mutation, variables);
    print(res);
    Get.snackbar(
      'Announcement Created',
      res["data"]["insert_announcement_one"]["title"] +
          ' created successfully.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future deleteAnnouncement(int id) async {
    String mutation =
        """
      mutation MyMutation(\$id: Int!) {
        delete_announcement(where: {id: {_eq: \$id}}) {
          affected_rows
        }
      } 
    """;

    Map<String, dynamic> variables = {
      "id": id,
    };

    await hasura.hasuraMutation(mutation, variables);

    Get.snackbar(
      'Announcement Deleted',
      'Deleted successfully.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

dynamic myEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}
