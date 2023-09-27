import 'dart:developer';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/models/add_guestbook.dart';
import 'package:churchappenings/models/get_church_facility%20model.dart';
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

  Future getChurchAffiliation() async {
    String query = """
     query MyQuery {
     facility {
     name
     id
  }
}
  """;

    var response = await hasura.hasuraQuery(query);
    log('res $response');

    return response["data"]["facility"];
  }

  Future getChurches() async {
    String query = """
    query MyQuery {
  facility(where: {mode: {_eq: "LIVE"}}) {
    name
    id
    country
    description
    division
    logo
    territory
  }
}
 """;

    var response = await hasura.hasuraQuery(query);
   // log('res $response');

    return response["data"]["facility"];
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

  addGuestApi(GuestBookInputModel model) async {
    log('memberid ${profileApi.memberId}');

    String query =
        """mutation MyMutation(\$age: Int!, \$church_affiliation: String!, \$country: String!, \$date_of_visit: timestamptz!, \$description: String!, \$email: String!, \$name: String!, \$phone_no: String!, \$request_call: Boolean!, \$requested_facility_id: Int!, \$requester_member_id: Int!, \$state: String!) {
    insert_guestbook(objects: {
      age: \$age,
      church_affiliation: \$church_affiliation,
      country: \$country,
      date_of_visit: \$date_of_visit,
      description: \$description,
      email: \$email,
      name: \$name,
      phone_no: \$phone_no,
      request_call: \$request_call,
      requested_facility_id: \$requested_facility_id,
      requester_member_id: \$requester_member_id,
      state: \$state
    }) {
      affected_rows
    }
  }""";

    Map<String, dynamic> variables = {
      "age": model.age,
      "church_affiliation": model.churchAffiliation,
      "country": model.country,
      "date_of_visit": model.dateOfVisit,
      "description": model.description,
      "email": model.email,
      "name": model.name,
      "phone_no": model.phoneNo,
      "request_call": model.requestCall,
      "requested_facility_id": model.requestedFacilityId,
      "requester_member_id": profileApi.memberId,
      "state": model.state,
    };

    var res = await hasura.hasuraMutation(query, variables);
    log('Response: $res');
    return res["data"]["insert_guestbook"]["affected_rows"];
  }
}
