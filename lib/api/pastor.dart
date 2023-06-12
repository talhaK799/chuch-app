import 'dart:convert';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';

class PastorAPI {
  final HasuraService hasura = HasuraService.to;
  final ProfileAPI profileApi = ProfileAPI.to;

  Future<bool> pastorDesignation() async {
    int memberId = profileApi.memberId!;
    String query = """
      query MyQuery(\$id: Int!) {
        designation(where: {_and: {member_designations: {member_id: {_eq: \$id}, designation_id: {_eq: "Pastor"}}}}) {
          title
        }
      }
    """;

    Map<String, dynamic> variables = {"id": memberId};

    var result = await hasura.hasuraQuery(query, variables);

    if (result["data"]["designation"].length == 1)
      return true;
    else
      return false;
  }

  Future searchPastors(String searchQuery) async {
    String query = """
      query MyQuery {
        member_designation(where: {_and: {designation_id: {_eq: "Pastor"}, member: {user: {name: {_ilike: "%$searchQuery%"}}}}}) {
          member {
            id
            user {
              name
            }
            member_facility_permissions(limit: 1) {
              facility {
                name
              }
            }
          }
        }
      }
    """;

    var result = await hasura.hasuraQuery(query);
    return result["data"]["member_designation"];
  }

  Future bookAppointment(
    String phoneNo,
    String address,
    String description,
    DateTime dateTime,
  ) async {}

  Future getPastorCalendarSettings() async {
    int id = profileApi.memberId!;
    String query = """
      query MyQuery {
        pastor_details(where: {member_id: {_eq: $id}}) {
          availibility
          secretary
          visibility
        }
      }
    """;

    var result = await hasura.hasuraQuery(query);
    return result["data"]["pastor_details"][0];
  }

  Future getPastorAvailibility(int id) async {
    String query = """
      query MyQuery {
        pastor_details(where: {member_id: {_eq: $id}}) {
          availibility
          secretary
          visibility
        }
      }
    """;

    var result = await hasura.hasuraQuery(query);
    return result["data"]["pastor_details"][0];
  }

  Future updatePastorCalendarSettings(
    bool visibility,
    dynamic availibility,
  ) async {
    int id = profileApi.memberId!;
    String query = """
      mutation MyMutation(\$secretary: Int, \$visibility: Boolean!, \$availibility: jsonb!) {
        update_pastor_details(where: {member_id: {_eq: $id}}, _set: {availibility: \$availibility, secretary: \$secretary, visibility: \$visibility}) {
          affected_rows
        }
      }
    """;

    Map<String, dynamic> variables = {
      "secretary": null,
      "visibility": visibility,
      "availibility": availibility
    };

    var result = await hasura.hasuraMutation(query, variables);
    print(result);
  }

  Future createAppointment(
    String desc,
    String address,
    String phoneNumber,
    DateTime dateTime,
    int pastorId,
  ) async {
    String query = """
      mutation MyMutation(\$phone: String!, \$requester_id: Int!, \$status: String!, \$description: String!, \$date_time: timestamptz!, \$address: String!, \$paster_id: Int!) {
        insert_paster_appointment(objects: {address: \$address, date_time: \$date_time, description: \$description, paster_id: \$paster_id, phone: \$phone, requester_id: \$requester_id, status: \$status}) {
          returning {
            id
          }
        }
      }
    """;

    Map<String, dynamic> variables = {
      "date_time": json.encode(dateTime, toEncodable: myEncode),
      "phone": phoneNumber,
      "requester_id": profileApi.memberId!,
      "status": "-",
      "description": desc,
      "address": address,
      "paster_id": pastorId,
    };

    var result = await hasura.hasuraMutation(query, variables);
    print(result);
  }

  Future listUpcoming() async {
    int pastorId = profileApi.memberId!;
    String query = """
      query MyQuery(\$id: Int!) {
        paster_appointment(where: {paster_id: {_eq: \$id}}) {
          description
          date_time
          address
          phone
          member {
            user {
              name
            }
          }
          status
        }
      }
    """;

    Map<String, dynamic> variables = {"id": pastorId};

    var result = await hasura.hasuraQuery(query, variables);
    return result["data"]["paster_appointment"];
  }

  Future listPast() async {}

  Future getAppointmentDetails(int id) async {}

  Future changeAppointmentStatus(int id) async {}
}

dynamic myEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}
