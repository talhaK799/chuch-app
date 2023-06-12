import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';

class PermissionAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future<dynamic> getPermissions(String permissionName) async {
    String query = """
      query MyQuery(\$member_id: Int!, \$facility: Int!, \$permission_name: String!) {
        member_facility_permission(where: {member_id: {_eq: \$member_id}, permission: {name: {_eq: \$permission_name}}, facility_id: {_eq: \$facility}}) {
          is_modify
          is_read
        }
      }
    """;

    Map<String, dynamic> variables = {
      "member_id": profileApi.memberId,
      "facility": profileApi.selectedChurchId,
      "permission_name": permissionName,
    };

    var res = await hasura.hasuraQuery(query, variables);

    return res["data"]["member_facility_permission"][0];
  }
}
