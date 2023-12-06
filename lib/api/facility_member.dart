import 'dart:developer';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:churchappenings/services/local_data.dart';

class FacilityMemberApi {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future getMembersFacilities() async {
    // print(profileApi.selectedChurchId);
    int? id = profileApi.memberId;
    print("Member ID => $id");
    if (id != null) {
      String query = """
        query MyQuery {
          facility_member(where: {member_id: {_eq: $id}}) {
            facility {
              name
              address
              id
            }
          }
        }
    """;

      // Map<String, dynamic> variables = {"uuid": id};

      var res = await hasura.hasuraQuery(query);
      print("**** Response ==== >>> $res");

      return res["data"]["facility_member"];
    }
  }
}
