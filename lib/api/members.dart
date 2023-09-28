import 'dart:developer';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:get/get.dart';

class MembersAPI {
  final HasuraService hasura = HasuraService.to;
  final ProfileAPI profileApi = ProfileAPI.to;

  Future<dynamic> getMembers() async {
    String query = """
      query MyQuery(\$id: Int!) {
        member_facility_permission(where: {facility_id: {_eq: \$id}}, distinct_on: member_id) {
          member {
            id
            user {
              name
              email
            }
          }
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": profileApi.selectedChurchId,
    };

    var result = await hasura.hasuraQuery(query, variables);
    return result["data"]["member_facility_permission"];
  }

  Future<dynamic> inviteMembers(String email) async {
    String query = """
      mutation MyMutation(\$id: Int!, \$name: String!, \$email: AWSEmail!){
        invite_member(email: \$email, facility_id: \$id, facility_name: \$name){
          message
          status
        }
      }
    """;

    String churchname = "";

    for (int i = 0; i < profileApi.churches.length; i++) {
      if (profileApi.churches[i].id == profileApi.selectedChurchId) {
        churchname = profileApi.churches[i].name;
        break;
      }
    }

    Map<String, dynamic> variables = {
      "id": profileApi.selectedChurchId,
      "name": churchname,
      "email": email,
    };

    var res = await hasura.hasuraMutation(query, variables);

    print(res);

    Get.snackbar(
      'Success',
      'Invite sent',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<dynamic> getMemberStatus(churchId) async {
    String query = """query MyQuery(\$to_church_id: Int, \$member_id: Int) {
    member_transfer(where: {member_id: {_eq: \$member_id}, to_church_id: {_eq: \$to_church_id}}) {
      from_church_id
      id
      member_id
      status
      to_church_id
    }
  }""";

    Map<String, dynamic> variables = {
      "to_church_id": churchId,
      "member_id": profileApi.memberId,
    };

    var result = await hasura.hasuraQuery(query, variables);
    log('mmmmmmmmmmmmmm$result');
    return result["data"]["member_transfer"];
  }

  Future<dynamic> memberTransfer(int toId) async {
    String query = """
      mutation MyMutation(\$id: Int!, \$toid: Int!, \$member: Int!,){
        insert_member_transfer(objects: {
          from_church_id: \$id,
          to_church_id: \$toid,
          member_id: \$member,
          status: "NOT_PROCESSING"
        }){
          returning {
            id
          }
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": profileApi.selectedChurchId == 99999999
          ? toId
          : profileApi.selectedChurchId,
      "toid": toId,
      "member": profileApi.memberId,
    };

    var res = await hasura.hasuraMutation(query, variables);

    print("res => $res");
    if (res == null) {
      return false;
    } else {
      return true;
    }

    // Get.snackbar(
    //   'Success',
    //   'Transfer request sent',
    //   snackPosition: SnackPosition.BOTTOM,
    // );
  }

  Future<dynamic> getAllChurches(String name) async {
    String query = """
      query MyQuery(\$name: String!) {
        facility(where: {name: {_ilike: \$name}}) {
          id
          name
          address
        }
      }
    """;

    Map<String, dynamic> variables = {
      "name": "%" + name + "%",
    };

    var result =
        await hasura.hasuraConnectAnonymus.query(query, variables: variables);

    return result["data"]["facility"];
  }
}
