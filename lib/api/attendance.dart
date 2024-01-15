import 'dart:convert';
import 'dart:developer';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';

class AttendanceAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future getAttendance() async {
    int? churchId = profileApi.selectedChurchId;
    int? memberId = profileApi.memberId;
    // String? name = profileApi.name;
    log('church id===> $churchId');
    log('member id===> $memberId');
    String query = """
      query myQuery {
        attendance(where: {member_id: {_eq:$memberId}, church_id: {_eq: $churchId}}) {
          date
        }
      }
      """;

    var res = await hasura.hasuraQuery(query);
    print('database Response==> $res');
    return res["data"]["attendance"];
  }

  Future takeAttendance() async {
    String query = """
     mutation myQuery(\$member_id: Int!, \$church_id: Int!, \$name: String!) {
      insert_attendance(objects: {church_id: \$church_id, member_id: \$member_id, name: \$name}) {
        affected_rows
      }
    }


    """;

    Map<String, dynamic> variables = {
      // "date": json.encode(date, toEncodable: myEncode),
      "member_id": profileApi.memberId,
      "church_id": profileApi.selectedChurchId,
      "name": profileApi.name,
    };
    try {
      var result = await hasura.hasuraMutation(query, variables);
      print(result);
    } catch (e) {
      print('error while taking attendance===> $e');
    }
  }

  dynamic myEncode(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }
}
