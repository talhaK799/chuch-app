import 'dart:convert';

import 'package:churchappenings/models/member-of.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:churchappenings/services/local_data.dart';
import 'package:churchappenings/utils/date-time-encode.dart';

class ProfileAPI {
  static ProfileAPI to = ProfileAPI();
  final HasuraService hasura = HasuraService.to;
  final localData = LocalData();
  List<Member> churches = [];
  int selectedChurchId = 0;
  String name = '';
  String email = '';
  String selectedChurchName = "";
  DateTime dob = DateTime.now();
  int? memberId;
  late String uuid;

  Future storeProfileInLocal(String uuidarg) async {
    print("@storeProfileLocally => $uuidarg");
    try {
      String query = """
          query MyQuery(\$uuid: String!) {
            user(where: {uuid: {_eq: \$uuid}}) {
              name
              email
              birthdate
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

      print("uuid => ${uuidarg}");

      uuid = uuidarg;
      Map<String, dynamic> variables = {"uuid": uuid};
      var res = await hasura.hasuraQuery(query, variables);
      print("res => $res");
      // Set member Id
      if (res != null) {
        memberId = res["data"]["member"][0]["id"] != null
            ? res["data"]["member"][0]["id"]
            : null;

        // Set User name
        name = res["data"]["user"][0]["name"] != null
            ? res["data"]["user"][0]["name"]
            : null;
        email = res["data"]["user"][0]["email"] != null
            ? res["data"]["user"][0]["email"]
            : null;
        // print(res["data"]["facility"]);
        // Set MemberOfChurches
        churches = memberOfModelFromJson(
          json.encode(res["data"]["facility"]),
        );

        print("Churches => ${churches.length}");

        // Selected Church Id
        int getSelectedChurchId = await localData.getInt('selected_church_id');
        if (getSelectedChurchId != 99999999)
          selectedChurchId = getSelectedChurchId;
        else if (res["data"]["facility"] !=
            null) if (res["data"]["facility"].length > 0) {
          selectedChurchId = res["data"]["facility"][0]["id"];
          selectedChurchName = res["data"]["facility"][0]["name"];
        }
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  Future toCheckMember(int memberId) async {
    // print("**** MEMBER ID **** $memberId");
    String query = """
      query MyQuery {
       facility_member(where: {member_id: {_eq: $memberId}}) {
        facility_id
      }
    }
    """;

    var res = await hasura.hasuraQuery(query);
    // print("**** tocheck Response ==== >>> $res");

    return res["data"]["facility_member"];
    // {data: {facility_member: []}}
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
        }
      }
    """;

    Map<String, dynamic> variables = {"uuid": memberId};

    var res = await hasura.hasuraQuery(query, variables);
    print("**** Profile Response ==== >>> $res");
    if (res == null) {
      return null;
    } else
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
