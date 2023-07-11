import 'dart:developer';

import 'package:churchappenings/api/profile.dart';

import '../services/hasura.dart';

class CheckPermission {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future<dynamic> fetchDataForCheckPermsion() async {
    String uuid = profileApi.memberId.toString();
    log("UUI:: $uuid");
    String query = """
query MyQuery {
  member_dept_permission(where: {member_id: {_eq: 23}, dept_id: {_eq: 26}}) {
    permission_id
    is_read
    is_modify
  }
}
""";
    var res = await hasura.hasuraQuery(query);
    print("Permission data Checking: $res");
    return res["data"]["member_dept_permission"];
  }
}
