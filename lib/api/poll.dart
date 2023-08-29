import 'dart:convert';
import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/models/creat_poll.dart';
import 'package:churchappenings/models/pemission.dart';
import 'package:churchappenings/models/poll.dart';
import 'package:churchappenings/services/hasura.dart';

class PollAPI {
  final HasuraService hasura = HasuraService.to;
  final ProfileAPI profileApi = ProfileAPI.to;

  Future<List<PollModel>?> fetchPolls() async {
    List<PollModel> data = [];

    try {
      String query = """
          query MyQuery {
            polling(where: {_and: {is_archived: {_eq: false}, is_upcoming: {_eq: false}}}) {
              id
              title
              desc
              options
             user_pols(where: {member_id: {_eq: 123}}) {
      selected_option
    }
            }
          }
        """;
      var res = await hasura.hasuraQuery(query);
      print("Get poll ====>>>>$res");
      print("lenght => ${res["data"]["polling"].length}");
      res["data"]["polling"].forEach((v) {
        data.add(PollModel.fromJson(v));
      });
      print("datt => ${data.length}");

      // data = pollModelFromJson(res["data"]["polling"]);
      // print("@poll response==>>>>>>${data[0].toJson()}");
    } catch (e) {
      print(e);
    }

    return data;
  }

  Future fatchPollEveryOne() async {
    try {
      String query = """
              query myQuery {
  polling(where: {poll_permission: {permission_type: {_eq: "EVERYONE"}}}) {

    desc
    facility_id
    id
    is_archived
    is_upcoming
    options

    scheduled_archieval
    start_date
    title
  }
}
        """;
      var res = await hasura.hasuraQuery(query);
      print("Get Everyone poll ====>>>>$res");
      print("lenght => ${res["data"]["polling"]}");
      // res["data"]["polling"].forEach((v) {
      //   data.add(PollModel.fromJson(v));
      // });
      // print("datt => ${data.length}");

      // data = pollModelFromJson(res["data"]["polling"]);
      // print("@poll response==>>>>>>${data[0].toJson()}");
    } catch (e) {
      print(e);
    }
  }

  Future<int> fetchNoOfPolls() async {
    int count = 0;

    try {
      String query = """
          query MyQuery {
            polling_aggregate(where: {_and: {is_archived: {_eq: false}, is_upcoming: {_eq: false}}}) {
              aggregate {
                count(columns: id)
              }
            }
          }
        """;
      var res = await hasura.hasuraQuery(query);

      count = res["data"]["polling_aggregate"]["aggregate"]["count"];
    } catch (e) {
      print(e);
    }

    return count;
  }

  Future addvote(int pollId, String selectedOption) async {
    try {
      // String query = """
      //   query MyQuery {
      //     member {
      //       id
      //     }
      //   }
      // """;

      // var res = await hasura.hasuraQuery(query);

      String mutation = """
        mutation MyMutation(\$poll_id: Int!, \$member_id: Int!, \$selected_option: String!) {
          insert_user_pols_one(object: {member_id: \$member_id, selected_option: \$selected_option, poll_id: \$poll_id}) {
            poll_id
            selected_option
            member {
              user {
                uuid
              }
            }
          }
        }
      """;

      Map<String, dynamic> variables = {
        "poll_id": pollId,
        "member_id": profileApi.memberId,
        "selected_option": selectedOption,
      };

      await hasura.hasuraMutation(mutation, variables);
    } catch (e) {}
  }

  Future checkPermissionForCreatePoll(String id) async {
    try {
      String query = """
         query MyQuery {
          member_facility_permission(where: {member: {id: {_eq:$id }}}) {
            facility_id
            is_modify
            is_read
            member_id
            permission_id
          }
         }
         """;
      var res = await hasura.hasuraQuery(query);
      // print("permission response==>>>>>>$res");

      return res;
    } catch (e) {
      print(e);
    }
  }

  Future createPoll(CreatePoll poll) async {
    try {
      String mutation = """
    mutation MyMutation(\$permission_id: Int!, \$poll_desc: String!, \$poll_dateAndTime: timestamptz!, \$facility_id: Int!, \$poll_convertedOptions: jsonb!, \$poll_optionType: String!, \$poll_title: String!) {
      insert_polling(objects: {
        desc: \$poll_desc,
        permission_id: \$permission_id,
        start_date: \$poll_dateAndTime, 
        facility_id: \$facility_id, 
        options: \$poll_convertedOptions,
        option_type: \$poll_optionType,
        title: \$poll_title
      }) {
        affected_rows
        returning {
          id
        }
      }
    }
  """;

      Map<String, dynamic> variables = {
        "poll_desc": poll.desc,
        "facility_id": poll.facilityId,
        "permission_id": poll.permissionId,
        "poll_dateAndTime": poll.startDate?.toUtc().toIso8601String(),
        "poll_convertedOptions":
            jsonEncode(poll.options?.map((option) => option.toJson()).toList()),
        "poll_optionType": poll.type,
        "poll_title": poll.title,
      };

      var res = await hasura.hasuraMutation(mutation, variables);
      print("poll respons==========>$res");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future creaPermission(Permission permission) async {
    try {
      String mutation = """
      mutation MyQuery(\$dept_id: String!, \$is_modify: Boolean!, \$is_read: Boolean!, \$permission_type: String!) {
       insert_poll_permissions(objects: {dept_id: \$dept_id, is_modify: \$is_modify, is_read: \$is_read, permission_type: \$permission_type}) {
        returning {
          dept_id
          id
          is_modify
          is_read
          permission_type
        }
      }
    }
    """;

      Map<String, dynamic> variables = {
        "dept_id": permission.departmentsId,
        "is_modify": permission.isModify,
        "is_read": permission.isRead,
        "permission_type": permission.title,
      };

      var res = await hasura.hasuraMutation(mutation, variables);
      return res;
      // print("==========>$res");
    } catch (e) {
      // Handle the error here or log it
      print("Error: $e");
    }
  }

  Future getDepts(int churchId) async {
    try {
      String query = """
        query MyQuery {
          department(where: {facility: {id: {_eq: 58}}}) {
           id
           name
          }
        }
      """;

      var res = await hasura.hasuraQuery(query);
      return res;
    } catch (e) {
      print(e);
    }
  }
}
