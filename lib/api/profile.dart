import 'dart:convert';

import 'package:churchappenings/models/member-of.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:churchappenings/services/local_data.dart';
import 'package:churchappenings/utils/date-time-encode.dart';

class ProfileAPI {
  static ProfileAPI to = ProfileAPI();
  final HasuraService hasura = HasuraService.to;
  final localData = LocalData();
  List<MemberOfModel> churches = [];
  int selectedChurchId = 0;
  String name = '';
  String email = '';
  int? memberId;
  late String uuid;

  Future storeProfileInLocal(String uuidarg) async {
    try {
      String query = """
          query MyQuery(\$uuid: String!) {
            user(where: {uuid: {_eq: \$uuid}}) {
              name
              email
            }

            facility {
              id
              name
              logo
            }

            member(where: {user: {uuid: {_eq: \$uuid}}}) {
              id
            }
          }
        """;

      uuid = uuidarg;
      Map<String, dynamic> variables = {"uuid": uuid};
      var res = await hasura.hasuraQuery(query, variables);

      // Set member Id
      memberId = res["data"]["member"][0]["id"];

      // Set User name
      name = res["data"]["user"][0]["name"];
      email = res["data"]["user"][0]["email"];

      // Set MemberOfChurches
      churches = memberOfModelFromJson(
        json.encode(res["data"]["facility"]),
      );

      // Selected Church Id
      int getSelectedChurchId = await localData.getInt('selected_church_id');
      if (getSelectedChurchId != 99999999)
        selectedChurchId = getSelectedChurchId;
      else if (res["data"]["facility"].length > 0)
        selectedChurchId = res["data"]["facility"][0]["id"];
    } catch (e) {
      print(e);
    }
  }

  Future getSkills() async {
    String query = """
      query MyQuery {
        skill(order_by: {title: asc}) {
          title
        }
      }
    """;
    var res = await hasura.hasuraQuery(query);

    return res["data"]["skill"];
  }

  Future getProfileData() async {
    print("**** MEMBER ID **** $memberId");
    String query = """
      query MyQuery(\$uuid: Int!) {
        member(where: {id:  {_eq: \$uuid}}) {
          occupation,
          emplymentStatus,
          new_job_noti
          user {
            birthdate,
            name,
            email
          }
        }
      }
    """;

    Map<String, dynamic> variables = {"uuid": memberId};

    var res = await hasura.hasuraQuery(query, variables);
    print("**** Response ==== >>> ${res["data"]["member"]}");

    return res["data"]["member"][0];
  }

  Future saveData(
    DateTime birthdate,
    String profession,
    String emplymentStatuss,
    bool notifyForNewJob,
  ) async {
    String query = """
      mutation MyMutation(\$occupation: String!,\$emplymentStatus: String!, \$new_job_noti: Boolean!, \$birthdate: timestamptz!) {
        update_user(where: {uuid: {_eq: $uuid}}, _set: {birthdate: \$birthdate}) {
          affected_rows
        }
        update_member(where: {id: {_eq: $memberId}}, _set: {occupation: \$occupation, emplymentStatus: \$emplymentStatus, new_job_noti: \$new_job_noti}) {
          affected_rows
        }
      }
    """;

    Map<String, dynamic> variables = {
      "occupation": profession,
      "emplymentStatus": emplymentStatuss,
      "birthdate": json.encode(birthdate, toEncodable: dateTimeEncode),
      "new_job_noti": notifyForNewJob
    };

    var res = await hasura.hasuraMutation(query, variables);
    print("Response => $res");
  }

  Future saveDeviceId(String id) async {
    String query = """
      mutation MyMutation {
        register_device(uid: $uuid, device_id: $id){
          message
          status
        }
      }
    """;

    Map<String, dynamic> variables = {};

    var res = await hasura.hasuraMutation(query, variables);
    print(res);
  }

  Future getMaintainanceData() async {
    String query = """
      query MyQuery {
        get_maintainance_data {
          status
          message
          data {
            enabled
            start_date
            end_date
            message
          }
        }
      }
    """;

    var res = await hasura.hasuraQuery(query);

    return res["data"];
  }
}
