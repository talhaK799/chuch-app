import 'dart:convert';
import 'dart:developer';

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
  String selectedChurchLogo = "";
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
              type
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
        print("memberId => $memberId");

        // Set User name
        name = res["data"]["user"][0]["name"] != null
            ? res["data"]["user"][0]["name"]
            : null;
        // print(res["data"]["user"][0]["type"]);
        email = res["data"]["user"][0]["email"] != null
            ? res["data"]["user"][0]["email"]
            : null;
        // print(res["data"]["facility"]);
        // Set MemberOfChurches
        churches = memberOfModelFromJson(
          json.encode(res["data"]["facility"]),
        );

        print("Churches => ${churches.length}");

        ///
        ///

        // Selected Church Id
        // int getSelectedChurchId = await localData.getInt('selected_church_id');
        // if (getSelectedChurchId != 99999999){
        //        selectedChurchId = getSelectedChurchId;
        //     log('selected church id debug.............$selectedChurchId');
        // }

        // else if (res["data"]["facility"] !=
        //     null) if (res["data"]["facility"].length > 0) {
        //   selectedChurchId = res["data"]["facility"][0]["id"];
        //   selectedChurchName = res["data"]["facility"][0]["name"];
        //    log('selected church id else  debug.............$selectedChurchId');
        // }
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  Future callQuery() async {
    String query = """
         query MyQuery(\$uuid: String!) {
  user(where: {uuid: {_eq: \$uuid}}) {
    name
    email
  }
}

        """;
    uuid = 'VXINAgnBEYNfTVCv0fIX0jgU0Mt1';
    Map<String, dynamic> variables = {"uuid": uuid};
    var res = await hasura.hasuraQuery(query, variables);
    print("res => $res");
  }

  Future toCheckMember(int memberId) async {
    print("**** MEMBER ID **** $memberId");
    String query = """
      query MyQuery {
       facility_member(where: {member_id: {_eq: $memberId}}) {
        facility_id
        facility{
          logo
          name
        }
      }
    }
    """;
    var res = await hasura.hasuraQuery(query);
    log("**** tocheck Response ==== >>> $res");

    if (res != null &&
        res["data"] != null &&
        res["data"]["facility_member"] != null) {
      var facilityMember = res["data"]["facility_member"];
      if (facilityMember is List && facilityMember.isNotEmpty) {
        int id = facilityMember[0]["facility_id"];
        await localData.setInt('selected_church_id', id);

        var name = facilityMember[0]["facility"]["name"];
        await localData.setString('selected_church_name', name);
        var logo = facilityMember[0]["facility"]["logo"];
        await localData.setString('selected_church_logo', logo);
        selectedChurchLogo = await localData.getString('selected_church_logo');
        selectedChurchName = await localData.getString('selected_church_name');
        selectedChurchId = await localData.getInt('selected_church_id');
        log("****......selected Church id**** $selectedChurchName");
      } else {
       
        await localData.setInt('selected_church_id', 99999999);
        selectedChurchId = await localData.getInt('selected_church_id');
        log("****............jjjjjjjjj........................ Selected Church id ID **** $selectedChurchId");
      }
    } else {
     
      log('unexpected error');
    }

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
