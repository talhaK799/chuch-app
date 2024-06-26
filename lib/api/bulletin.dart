import 'dart:convert';
import 'dart:developer';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/models/assignment.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class BulletinAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;
  String? deptHappeningId;
  var uuid = Uuid();
  Logger log = Logger();

  assignMemDesig(Assginment assignment) async {
    String query = """
    mutation InsertAssignment(\$assigne: String!, \$assigne_uuid: String!, \$bulletin_id: String!, \$happening_id: String!,\$assignment_type: String!, \$status: String!) {
      insert_assignment(objects: {assigne: \$assigne, assigne_uuid: \$assigne_uuid, bulletin_id: \$bulletin_id, happening_id: \$happening_id,assignment_type: \$assignment_type,status: \$status}) {
        affected_rows
      }
    }
  """;

    Map<String, dynamic> variables = {
      "assigne": assignment.assignee,
      "assigne_uuid": assignment.uuid,
      "bulletin_id": assignment.bulletinId,
      "happening_id": assignment.deptHappeningId,
      "assignment_type": assignment.assignmentType,
      "status": assignment.status
    };

    var res = await hasura.hasuraMutation(query, variables);
    print('Response: $res');
    return res["data"]["insert_assignment"]["affected_rows"];
  }

  addMemberDesign(Assginment assignment) async {
    String query = """
    mutation MyQuery(\$date_time: timestamptz!, \$description: String!, \$id: String!, \$title: String!, \$type: String!) {
      insert_happening(objects: {date_time: \$date_time, description: \$description, id: \$id, title: \$title, type: \$type}) {
        affected_rows
      }
    }
  """;

    Map<String, dynamic> variables = {
      "date_time": assignment.datetime,
      "type": assignment.type,
      "description": assignment.description,
      "id": assignment.deptHappeningId,
      "title": assignment.title,
    };

    var res = await hasura.hasuraMutation(query, variables);
    print('Response: $res');
    return res["data"]["insert_happening"]["affected_rows"];
  }

  assigndept(Assginment assignment) async {
    print({assignment.deptHappeningId});
    String query = """
mutation MyMutation(\$dept_happening_id: String!, \$bulletin_id: String!, \$assignment_type: String!, \$status: String!, \$assignees: String!) {
  insert_dept_assignment(objects: {dept_happening_id: \$dept_happening_id, bulletin_id: \$bulletin_id,assignment_type: \$assignment_type,
        status: \$status,
        assignees: \$assignees}) {
    affected_rows
  }
}

""";
    Map<String, dynamic> variables = {
      "dept_happening_id": assignment.deptHappeningId,
      "bulletin_id": assignment.bulletinId,
      "assignment_type": assignment.assignmentType,
      "status": assignment.status,
      "assignees": assignment.assignee
    };
    var res = await hasura.hasuraMutation(query, variables);
    print('Response: $res');
    return res["data"]["insert_dept_assignment"]["affected_rows"];
  }

  addAssignmentDepartment(Assginment assignment) async {
    // var  deptHappeningId = "dhp-" +
    //       profileApi.selectedChurchId.toString() +
    //       "-" +
    //       DateTime.now().toString();
    print('${assignment.deptHappeningId}................');

    String query = """
    mutation MyMutation(\$date_time: timestamptz!, \$dept_id: Int!, \$description: String!, \$id: String!, \$title: String!) {
      insert_dept_happening(objects: {
        date_time: \$date_time,
        dept_id: \$dept_id,
        description: \$description,
        id: \$id,
        title: \$title,
      }) {
        affected_rows
      }
    }
  """;

    Map<String, dynamic> variables = {
      "date_time": assignment.datetime,
      "dept_id": assignment.deptid,
      "description": assignment.description,
      "id": assignment.deptHappeningId,
      "title": assignment.title
    };

    var res = await hasura.hasuraMutation(query, variables);
    print('Response: $res');
    return res["data"]["insert_dept_happening"]["affected_rows"];
  }

  Future getHintsEmail() async {
    String query = """
    query MyQuery(\$facility_id: Int) {
      facility_member(where: {facility_id: {_eq: \$facility_id}}) {
        member {
          user {
            email
            uuid
            }
        }
      }
    }
  """;

    Map<String, dynamic> variables = {
      "facility_id": profileApi.selectedChurchId,
    };

    try {
      var response = await hasura.hasuraQuery(query, variables);
      print('res $response');
      if (response.containsKey("data")) {
        List<dynamic> emailList = response["data"]["facility_member"]
            .map((item) => item["member"]["user"])
            .toList();

        return emailList;
      } else {
        return [];
      }
    } catch (e) {
      print('Error: $e');

      return null;
    }
  }

  Future getDesignations() async {
    String query = """
    query MyQuery {
      designation {
        title
      }
    }
  """;

    var response = await hasura.hasuraQuery(query);
    print('res $response');

    return response["data"]["designation"];
  }

  Future getdepartments() async {
    String query = """
    query MyQuery(\$facility_id: Int) {
      department(where: {facility_id: {_eq: \$facility_id}}) {
        name
        id
      }
    }
  """;

    Map<String, dynamic> variables = {
      "facility_id": profileApi.selectedChurchId,
    };

    var response = await hasura.hasuraQuery(query, variables);
    print('res $response');

    return response["data"]["department"];
  }

  Future<dynamic> fetchUpComingBulletins(String currentDate) async {
    print("AAA99:: $currentDate");
    String query = """
query MyQuery {
  bulletin(where: {facility_id: {_eq: 58}, is_draft: {_eq: false}, created_at: {_gte: "$currentDate"}}, order_by: {created_at: asc}) {
    name
    image
    id
    created_at
  }
}
""";

    var res = await hasura.hasuraQuery(query);
    print('bulletins by date: $res');
    return res["data"]["bulletin"];
  }

  Future<dynamic> fetchBulletinsByDate(String date) async {
    String query = """
query MyQuery {
  bulletin(where: {facility_id: {_eq: 58}, is_draft: {_eq: false}, created_at: {_eq: "$date"}}) {
    name
    image
    id
  }
}
""";

    var res = await hasura.hasuraQuery(query);
    print('bulletins by date: $res');
    return res["data"]["bulletin"];
  }

  Future<dynamic> getBulletins(int churchid) async {
    log.d("aaaaaa222: $churchid");
    String query = """
      query MyQuery(\$facility: Int!) {
        bulletin(where: {facility_id: {_eq: \$facility}, is_draft: {_eq: false}}) {
          name
          image
          id
        }
      }
    """;

    Map<String, dynamic> variables = {"facility": churchid};

    var res = await hasura.hasuraQuery(query, variables);

    print("By churchId: $res");

    return res["data"]["bulletin"];
  }

  Future<dynamic> getDraftBulletins(int churchid) async {
    String query = """
      query MyQuery(\$facility: Int!) {
        bulletin(where: {facility_id: {_eq: \$facility}, is_draft: {_eq: true}}) {
          name
          id
          responsibility
        }
      }
    """;

    Map<String, dynamic> variables = {
      "facility": churchid,
    };

    var res = await hasura.hasuraQuery(query, variables);

    return res["data"]["bulletin"];
  }

  Future<dynamic> getBulletinById(String id) async {
    log.d("checkkkkkkkkkk=====>>>>> $id");
    String query = """
      query MyQuery(\$id: String!) {
        bulletin(where: {id: {_eq: \$id}}) {
          assignments {
            assigne
            happening {
              title
              date_time
            }
          }
          image
          is_private
          is_draft
          name
          subtitle
          responsibility
          id
          description
          dept_public_hostings {
            date_time
            message
            department {
              name
            }
            sender_name
          }
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": id,
    };

    var res = await hasura.hasuraQuery(query, variables);
    return res["data"]["bulletin"][0];
  }

  getDeptsbyId(String id, String type) async {
    String query = """
  query MyQuery(\$id: String!,\$type: String!) {
    bulletin(where: {id: {_eq: \$id}}) {
      dept_assignments(where: {assignment_type: {_eq: \$type}}) {
        bulletin_id
        dept_happening_id
        assignees
      assignment_type
      status
        dept_happening {
          date_time
          dept_id
          description
          id
          title
          department {
          name
        }
      }
      }
    }
  }
  """;

    Map<String, dynamic> variables = {"id": id, "type": type};

    var res = await hasura.hasuraQuery(query, variables);
    print('$res.....');

    return res["data"]["bulletin"][0]["dept_assignments"];
  }

  Future<dynamic> getEventsByBulletinId(String id, String type) async {
    String query = """
      query MyQuery(\$id: String!, \$type: String!) {
      bulletin(where: {id: {_eq: \$id}}) {
        assignments(where: {assignment_type: {_eq: \$type}}) {
          assigne
          assignment_type
          status
          happening {
            title
            date_time
          }
        }
        name
      }
    }
    """;

    Map<String, dynamic> variables = {"id": id, "type": type};

    var res = await hasura.hasuraQuery(query, variables);

    return res["data"]["bulletin"][0]["assignments"];
  }

  Future<dynamic> getEligiblePublicDepartment() async {
    String query = """
      query MyQuery(\$id: Int!) {
        member_dept_permission(where: {_and: {permission_id: {_eq: "DEPARTMENT_PUBLIC_POSTING"}, department: {facility_id: {_eq: \$id}}}}, distinct_on: dept_id) {
          department {
            id
            name
          }
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": profileApi.selectedChurchId,
    };

    var res = await hasura.hasuraQuery(query, variables);

    print("abid2");
    print("check: $res");
    return res["data"]["member_dept_permission"];
  }

  Future<dynamic> getPublicPostingBulletinById(String id) async {
    print("a2222:: $id");
    String query = """
      query MyQuery(\$id: String!) {
        bulletin(where: {id: {_eq: \$id}}) {
          dept_public_hostings {
            date_time
            message
            department {
              name
            }
            sender_name
          }
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": id,
    };

    var res = await hasura.hasuraQuery(query, variables);
    print("abid1");
    return res["data"]["bulletin"][0]["dept_public_hostings"];
  }

  Future addPublicPosting(
    int deptId,
    String message,
    String bulletinId,
  ) async {
    var todayNow = DateTime.now();

    String mutation = """
      mutation MyMutation(\$sender_name: String!, \$sender_id: String!, \$sender_dept_id: Int!, \$message: String!, \$bulletin_id: String!, \$date_time: timestamp!) {
        insert_dept_public_posting(objects: {date_time: \$date_time, bulletin_id: \$bulletin_id, sender_dept_id: \$sender_dept_id, sender_id: \$sender_id, sender_name: \$sender_name, message: \$message}) {
          affected_rows
        }
      }
    """;

    Map<String, dynamic> variables = {
      "sender_name": profileApi.name,
      "sender_id": profileApi.memberId.toString(),
      "sender_dept_id": deptId,
      "message": message,
      "date_time": json.encode(todayNow, toEncodable: myEncode),
      "bulletin_id": bulletinId,
    };

    hasura.hasuraMutation(mutation, variables);
  }

  Future createBulletin(
    String name,
    String image,
    String subtitle,
    String description,
    String permission,
    bool isdraft,
  ) async {
    String mutation = """
    mutation MyMutation(\$id: String!, \$image: String!, \$name: String!, \$description: String!, \$facility_id: Int!, \$subtitle: String!, \$permission: String!, \$createdBy: Int!, \$is_draft: Boolean!) {
      insert_bulletin_one(object: {id: \$id, image: \$image, name: \$name, responsibility: [], facility_id: \$facility_id, subtitle: \$subtitle, description: \$description, permission: \$permission, created_by: \$createdBy, is_draft: \$is_draft}) {
        id
      }
    }
  """;

    Map<String, dynamic> variables = {
      "id": "bulletin-" +
          profileApi.selectedChurchId.toString() +
          "-" +
          uuid.v1(),
      "name": name,
      "image": image,
      "facility_id": profileApi.selectedChurchId,
      "description": description,
      "subtitle": subtitle,
      "permission": permission,
      "createdBy": profileApi.memberId,
      "is_draft": isdraft,
    };

    print(variables.toString());

    await hasura.hasuraMutation(mutation, variables);
  }

  Future addResponsibility(String id, dynamic responsibility) async {
    String mutation = """
    mutation MyMutation(\$id: String!, \$responsibility: jsonb!) {
      update_bulletin(where: {id: {_eq: \$id}}, _set: {responsibility: \$responsibility}) {
        affected_rows
      }
    }
  """;

    Map<String, dynamic> variables = {
      "id": id,
      "responsibility": responsibility
    };
    await hasura.hasuraMutation(mutation, variables);
  }
}

dynamic myEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}
