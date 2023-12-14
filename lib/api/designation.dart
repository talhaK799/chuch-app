

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';

class DesginationAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future getMemberDesignation() async {
    // print(profileApi.selectedChurchId);
    int? id = profileApi.memberId;
    print("Member ID => $id");
    if (id != null) {
      String query = """
        query MyQuery {
          designation(where: {title: {_eq: "Pastor"}}) {
            member_designations(where: {member_id: {_eq: $id}}) {
              designation_id
              member_id
            }
          }
        }
    """;

      // Map<String, dynamic> variables = {"uuid": id};

      var res = await hasura.hasuraQuery(query);
      print("**** Response ==== >>> $res");

      return res["data"]["designation"][0]["member_designations"];
    }
  }
}
