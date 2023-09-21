import 'dart:convert';
import 'dart:developer';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/models/add_guestbook.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:churchappenings/utils/date-time-encode.dart';

class GuestBookAPI {
  final HasuraService hasura = HasuraService.to;
  final ProfileAPI profileApi = ProfileAPI.to;
  Future<List<GuestBookInputModel>> getGuestData() async {
    String query = """
      query MyQuery(\$requester_member_id: Int!) {
        guestbook(where: { requester_member_id: { _eq: \$requester_member_id } }) {
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

    var variables = {
      "requester_member_id": profileApi.memberId,
    };

    try {
      var res = await hasura.hasuraQuery(query, variables);
      log('Response: $res');

      if (res != null &&
          res["data"] != null &&
          res["data"]["guestbook"] != null) {
        List<dynamic> guestbookData = res["data"]["guestbook"];
        List<GuestBookInputModel> guestList = guestbookData
            .map((entry) => GuestBookInputModel.fromJson(entry))
            .toList();

        return guestList;
      } else {
        return [];
      }
    } catch (error) {
      print("Error fetching data: $error");
      return [];
    }
  }
  // Future getGuestData() async {
  //   String query = """
  //         query MyQuery (\$requester_member_id: Int! ){
  // guestbook(where: {requester_member_id: {_eq: \$requester_member_id}}) {
  //   age
  //   church_affiliation
  //   country
  //   date_of_visit
  //   description
  //   email
  //   id
  //   name
  //   phone_no
  //   request_call
  //   requested_facility_id
  //   requester_member_id
  //   state
  // }
  //    }
  //   """;
  //   var variable = {
  //     "requester_member_id": profileApi.memberId,
  //   };

  //   var res = await hasura.hasuraQuery(query, variable);
  //   log('Response: $res');
  //   return res["data"]["guestbook"];
  // }

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

    log('${res}...............');
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
