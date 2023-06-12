import 'dart:convert';

import 'package:churchappenings/services/hasura.dart';

import 'profile.dart';

class CalendarAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future<dynamic> getUpcomingPersonalCalendar() async {
    var todayNow = DateTime.now();
    String uuid = profileApi.uuid;

    String query = """
      query MyQuery(\$today: timestamptz!, \$uuid: String!) {
        happening(
          order_by: {date_time: asc},
          where: {
            _and: [
              {date_time: {_gte: \$today}},
              {
                _or: [
                  {event: {type: {_is_null: false}}}, 
                  {assignment: {assigne_uuid: {_eq: \$uuid}}}, 
                  {facility_event: {_and: [
                    {type: {_is_null: false}}, 
                    {facility_event_invitations: {uuid: {_eq: \$uuid}}}
                  ]}}
                ]
              }
            ]
          }) {
          id
          title
          date_time
          assignment {
            assigne_uuid
          }
          event {
            type
          }
          facility_event {
            type
          }
        }
      }
    """;

    Map<String, dynamic> variables = {
      "uuid": uuid,
      "today": json.encode(todayNow, toEncodable: myEncode),
    };

    var res = await hasura.hasuraQuery(query, variables);
    return res["data"]["happening"];
  }

  Future<dynamic> getPastPersonalCalendar(int offset) async {
    var todayNow = DateTime.now();
    String uuid = profileApi.uuid;

    String query = """
      query MyQuery(\$today: timestamptz!, \$uuid: String!) {
        happening(
          limit: 10,
          offset: $offset,
          order_by: {date_time: desc},
          where: {
            _and: [
              {date_time: {_lt: \$today}},
              {
                _or: [
                  {event: {type: {_is_null: false}}}, 
                  {assignment: {assigne_uuid: {_eq: \$uuid}}}, 
                  {facility_event: {_and: [
                    {type: {_is_null: false}}, 
                    {facility_event_invitations: {uuid: {_eq: \$uuid}}}
                  ]}}
                ]
              }
            ]
          }) {
          id
          title
          date_time
          assignment {
            assigne_uuid
          }
          event {
            type
          }
          facility_event {
            type
          }
        }
      }
    """;
    Map<String, dynamic> variables = {
      "uuid": uuid,
      "today": json.encode(todayNow, toEncodable: myEncode),
    };

    var res = await hasura.hasuraQuery(query, variables);
    return res["data"]["happening"];
  }
}

dynamic myEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}
