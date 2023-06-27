import 'package:churchappenings/api/profile.dart';

import '../services/hasura.dart';

class PrivatePostingApi {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future createPrivatePosting({
    required String title,
    required String description,
    required String image,
    required String deptId,
  }) async {
    int senderId = profileApi.memberId!;
    String senderName = profileApi.name;
    int dept = int.parse(deptId);

    print("title: $title");
    print("description : $description");
    print("image : $image");

    String mutation = """
     mutation MyMutation(\$senderName: String!, \$senderId: String!, \$dept: Int!, \$title: String!, \$description: String!, , \$image: String!) {
  insert_dept_private_posting(objects: {sender_dept_id: \$dept, sender_id: \$senderId, sender_name: \$senderName, title: \$title,  description: \$description,  image: \$image}) {
    affected_rows
  }
}
      }
    """;

    Map<String, dynamic> variables = {
      "sender_id": senderId,
      "sender_name": senderName,
      "sender_dept_id": deptId,
      "image": image,
      "title": title,
      "description": description,
    };

    var res = await hasura.hasuraMutation(mutation, variables);
    print("res=> $res");
    // return happeningId;
  }
}
