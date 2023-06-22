import 'dart:developer';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';

class DepartmentAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future getAllDepartments() async {
    int id = profileApi.selectedChurchId;

    String query = """
      query MyQuery {
          department(where: {facility_id: {_eq: $id}}) {
            name
            desc
            id
          }
        }
    """;

    var res = await hasura.hasuraQuery(query);
    log('AAAAAAAAAA::: $id');
    print("AAA:: $res");
    return res["data"]["department"];
  }

  Future getDepartmentsYourMemberOff() async {
    print(profileApi.selectedChurchId);
    int? id = profileApi.memberId;
    print("Member ID => $id");
    if (id != null) {
      String query = """
        query MyQuery {
          department_join_req(where: {status: {_eq: "APPROVED"}, member_id: {_eq: $id}}) {
            department {
              name
              desc
              id
            }
          }
        }
    """;

      // Map<String, dynamic> variables = {"uuid": id};

      var res = await hasura.hasuraQuery(query);
      print("**** Response ==== >>> $res");

      return res["data"]["department_join_req"];
    }
  }

  Future deptJoinRequest(int deptId) async {
    int? id = profileApi.memberId;
    print("Member ID => $id And Dept ID =>$deptId");
    String mutation = """mutation MyQuery(\$dept_id: Int!, \$member_id: Int!) {
  insert_department_join_req(objects: {member_id: \$member_id, dept_id: \$dept_id}) {
    affected_rows
  }
}""";

    Map<String, dynamic> variables = {"dept_id": deptId, "member_id": id};

    var res = await hasura.hasuraMutation(mutation, variables);
    print("**** Response ==== >>> $res");
  }

  Future<dynamic> getPublicDepartment(String deptId) async {
    String query = """
query MyQuery {
  dept_public_posting(where: {sender_dept_id: {_eq: $deptId}}) {
    id
    message
    sender_name
    bulletin {
      id
      name
      image
      subtitle
    }
  }
}
""";
    // Map<String, String> variables = {
    //   "id": deptId,
    // };
    print(query);
    // print(variables);
    log("PP: $deptId");
    var result = await hasura.hasuraQuery(query);

    print("ABB:: $result");

    return result["data"]["dept_public_posting"];
  }

  Future getPrivateChatOfDepartment(String deptId) async {}

  Future addPrivateChatOfDepartment(String deptId, String message) async {}

  Future getInventoryDepartment(String deptId, String message) async {}

  Future addInventoryDepartment(String deptId) async {}

  Future editInventoryDepartment(String deptId) async {}

  Future removeInventoryDepartment(String deptId) async {}

  Future membersDepartment(String deptId) async {}

  Future inviteMembersDepartment(String deptId) async {}

  Future removeMembersDepartment(String deptId) async {}

  Future editPermissionMembersDepartment(String deptId) async {}
}
