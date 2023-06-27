import 'dart:convert';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class BulletinAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;
  var uuid = Uuid();
  Logger log = Logger();

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

  Future<dynamic> getEventsByBulletinId(String id) async {
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
          name
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": id,
    };

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
  ) async {
    String mutation = """
      mutation MyMutation(\$id: String!, \$image: String!, \$name: String!, \$description: String!, \$facility_id: Int!, \$subtitle: String!) {
      insert_bulletin_one(object: {id: \$id, image: \$image, name: \$name, responsibility: [], facility_id: \$facility_id, subtitle: \$subtitle, description: \$description}) {
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
