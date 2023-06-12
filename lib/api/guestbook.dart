import 'dart:convert';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:churchappenings/utils/date-time-encode.dart';

class GuestBookAPI {
  final HasuraService hasura = HasuraService.to;
  final ProfileAPI profileApi = ProfileAPI.to;

  Future getUpcomingGuestList() async {
    var todayNow = DateTime.now();

    String query = """
      query MyQuery(\$id: Int!, \$today: timestamptz!) {
        guestbook(where: {_and: {requested_facility_id: {_eq: \$id}, date_of_visit: {_gte: \$today}}}) {
          date_of_visit
          name
          id
        }
      }
    """;

    Map<String, dynamic> variables = {
      "today": json.encode(todayNow, toEncodable: dateTimeEncode),
      "id": profileApi.selectedChurchId,
    };

    var res = await hasura.hasuraQuery(query, variables);
    return res["data"]["guestbook"];
  }

  Future<dynamic> getSingleVisitationRequest(int id) async {
    String query = """
      query MyQuery(\$id: Int!) {
        guestbook(where: {id: {_eq: \$id}}) {
          age
          church_affiliation
          country
          date_of_visit
          description
          email
          id
          name
          phone_no
          request_call
          requested_facility_id
          requester_member_id
          state
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": id,
    };

    var res = await hasura.hasuraQuery(query, variables);
    return res["data"]["guestbook"][0];
  }
}
