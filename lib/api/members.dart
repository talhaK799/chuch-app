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
      "id": profileApi.selectedChurchId,
      "toid": toId,
      "member": profileApi.memberId,
    };

    var res = await hasura.hasuraMutation(query, variables);

    print("res => $res");

    Get.snackbar(
      'Success',
      'Transfer request sent',
      snackPosition: SnackPosition.BOTTOM,
    );
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
