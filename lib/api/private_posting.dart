import 'package:churchappenings/api/profile.dart';

import '../services/hasura.dart';

class PrivatePostingApi {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future fetchPrivatePost(String deptId) async {
    String query = """
   query MyQuery {
  dept_private_posting(where: {department: {id: {_eq: $deptId}}}) {
    id
    image
    sender_dept_id
    sender_id
    sender_name
    title
    description
    date_time
  }
}
    """;
    print(query);
    var res = await hasura.hasuraQuery(query);

    print("fetchPrivatePost:: $res");
    return res["data"]["dept_private_posting"];
  }

  Future createPrivatePosting({
    required String title,
    required String description,
    required String image,
    required String deptId,
  }) async {
    String senderId = profileApi.memberId!.toString();
    String senderName = profileApi.name;
    int dept = int.parse(deptId);

    print("title: $title");
    print("description : $description");
    print("image : $image");
    print("deptId : $deptId");
    print("senderId : $senderId");
    print("senderName : $senderName");

    String mutation = """
     mutation MyMutation(\$senderName: String!, \$senderId: String!, \$dept: Int!, \$title: String!, \$description: String!, , \$image: String!) {
  insert_dept_private_posting(objects: {sender_dept_id: \$dept, sender_id: \$senderId, sender_name: \$senderName, title: \$title,  description: \$description,  image: \$image}) {
    affected_rows
  }
}
    """;

    Map<String, dynamic> variables = {
      "senderName": senderName,
      "senderId": senderId,
      "dept": deptId,
      "title": title,
      "description": description,
      "image": image,
    };

    print(mutation);
    print(variables);

    var res = await hasura.hasuraMutation(mutation, variables);
    print("res=> $res");
    // return happeningId;
  }
}
