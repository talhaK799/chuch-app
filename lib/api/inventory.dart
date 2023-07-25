import 'dart:developer';

import 'package:churchappenings/api/profile.dart';

import '../services/hasura.dart';

class InventoryApi {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future fetchInventory(String deptId) async {
    String query = """
query MyQuery {
  department_owned_inventory(where: {department: {id: {_eq: "$deptId"}}}) {
    created_at
    dept_id
    description
    id
    name
    quantity
  }
}
""";

    var res = await hasura.hasuraQuery(query);
    print('Inventory data: $res');
    return res["data"]["department_owned_inventory"];
  }

  Future borrowedInventory(String deptId) async {
    log("id::111 $deptId");
    String query = """
query MyQuery {
  department_borrowed_inventory(where: {department: {id: {_eq: "$deptId"}}}) {
    borrowed_from
    created_at
    description
    due_date
    id
    name
    quantity
  }
}
""";

    var res = await hasura.hasuraQuery(query);
    print('borrowed inventory data: $res');
    return res["data"]["department_borrowed_inventory"];
  }

  Future permission({required String memberId, required String deptId}) async {
    log("deptId111: $deptId");
    log("memberId::111 $memberId");
    String query = """
query MyQuery {
  member_dept_permission(where: {member_id: {_eq: "$memberId"}, department: {id: {_eq: "$deptId"}}}) {
    department {
      department_borrowed_inventories {
        id
        name
        quantity
        description
        borrowed_from
      }
      department_owned_inventories {
        name
        id
        quantity
      }
    }
  }
}
""";

    var res = await hasura.hasuraQuery(query);
    print('permission data: $res');
    // return res["data"]["department_borrowed_inventory"];
  }
}
