import 'dart:developer';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/models/guest_chat_model.dart';
import 'package:churchappenings/services/hasura.dart';

class GuestChatApi {
  
  final ProfileAPI profileApi = ProfileAPI.to;

  final HasuraService hasura = HasuraService.to;

  sendMessage(String message) async {
    log('memberid${profileApi.memberId}');
    String query = """
    mutation MyQuery(\$message: String!, \$member_id: Int!) {
      insert_guest_messages(objects: {member_id: \$member_id, message: \$message}) {
        affected_rows
      }
    }
  """;

    Map<String, dynamic> variables = {
      "message": message,
      "member_id": profileApi.memberId,
    };

    var res = await hasura.hasuraMutation(query, variables);
    log('Response: $res');
    return res["data"]["insert_guest_messages"]["affected_rows"];
  }



  Future<List<GuestChatModel>> getChatMessages() async {
  String query = """
    query MyQuery {
      guest_messages(order_by: {created_at: desc}) {
        id
        member_id
        message
        created_at
        member {
          user {
            name
          }
        }
      }
    }
  """;

  var response = await hasura.hasuraQuery(query);

  if (response["data"] != null) {
    List<dynamic> messageList = response["data"]["guest_messages"];
    List<GuestChatModel> chatMessages = [];

    for (var messageData in messageList) {
      chatMessages.add(GuestChatModel(
        id: messageData["id"],
        memberId: messageData["member_id"],
        message: messageData["message"],
        createdAt: DateTime.parse(messageData["created_at"]),
        userName: messageData["member"]["user"]["name"],
      ));
    }

    return chatMessages;
  } else {
    throw Exception("Failed to fetch chat messages");
  }
}



}
