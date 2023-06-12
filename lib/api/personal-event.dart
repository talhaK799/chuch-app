import 'dart:convert';

import 'package:churchappenings/services/hasura.dart';

import 'profile.dart';

class PersonalEventAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future<dynamic> getAllPersonalEvent() async {
    var todayNow = DateTime.now();
    int owner = profileApi.memberId ?? 99999999999999;
    print(owner);

    String query = """
      query MyQuery(\$owner: Int!, \$today: timestamptz!) {
        event(order_by: {happening: {date_time: asc}}, where: {_and: {owner: {_eq: \$owner}, happening: {date_time: {_gte: \$today}}}}) {
          happening {
            id
            title
            date_time
          }
        }
      }
    """;

    Map<String, dynamic> variables = {
      "owner": owner,
      "today": json.encode(todayNow, toEncodable: myEncode),
    };

    var res = await hasura.hasuraQuery(query, variables);

    return res["data"]["event"];
  }

  Future<dynamic> getPastPersonalEvents(int offset) async {
    var todayNow = DateTime.now();
    int owner = profileApi.memberId ?? 99999999999999;

    String query = """
      query MyQuery(\$today: timestamptz!, \$owner: Int!) {
        event(where: {_and: {owner: {_eq: \$owner}, happening: {date_time: {_lt: \$today}}}}, order_by: {happening: {date_time: desc}}, limit: 10, offset: $offset) {
          happening {
            id
            title
            description
            date_time
          }
          is_private
          owner
        }
      }
    """;

    Map<String, dynamic> variables = {
      "owner": owner,
      "today": json.encode(todayNow, toEncodable: myEncode),
    };
    var res = await hasura.hasuraQuery(query, variables);
    return res["data"]["event"];
  }

  Future<String> createPersonalEvent({
    required String title,
    required String description,
    required DateTime eventDateTime,
    required String type,
    required String image,
  }) async {
    int owner = profileApi.memberId!;
    var dateTime = DateTime.now();
    String happeningId = 'personal-$dateTime-$owner';

    String mutation = """
      mutation MyMutation(\$happening_id: String!, \$type: String!, \$owner: Int!, \$image: String!, \$title: String!, \$description: String!, \$date_time: timestamptz!) {
        insert_happening(objects: {id: \$happening_id, title: \$title, description: \$description, date_time: \$date_time}) {
          affected_rows
        }
        insert_event(objects: {happening_id: \$happening_id, image: \$image, is_private: true, owner: \$owner, type: \$type}) {
          affected_rows
        }
      }
    """;

    Map<String, dynamic> variables = {
      "happening_id": happeningId,
      "type": type,
      "owner": owner,
      "image": image,
      "title": title,
      "description": description,
      "date_time": json.encode(eventDateTime, toEncodable: myEncode),
    };

    await hasura.hasuraMutation(mutation, variables);

    return happeningId;
  }

  Future<dynamic> getPersonalEvent(String id) async {
    String query = """
    query MyQuery(\$id: String!) {
      happening(where: {id: {_eq: \$id}}) {
        event {
          event_invitations {
            email
          }
          type
          image
        }
        date_time
        description
        title
        id
      }
    }
  """;

    Map<String, dynamic> variables = {
      "id": id,
    };

    return await hasura.hasuraQuery(query, variables);
  }

  Future inviteMemberUsingEmail(String email, String eventId) async {
    String getUUID = """
      query MyQuery(\$email: String!) {
        user(where: {email: {_eq: \$email}}, limit: 1) {
          uuid
        }
      }
    """;

    Map<String, dynamic> variables = {
      "email": email,
    };

    var res = await hasura.hasuraQuery(getUUID, variables);
    String uuid = 'null';

    if (res['data']['user'].length > 0) {
      uuid = res['data']['user'][0]['uuid'];
    }

    String mutation = """
      mutation MyMutation(\$email: String!, \$event_id: String!, \$uuid: String!) {
        insert_event_invitation_one(object: {email: \$email, event_id: \$event_id, uuid: \$uuid}) {
          email
        }
      }
    """;

    variables = {
      "email": email,
      "event_id": eventId,
      "uuid": uuid,
    };

    return await hasura.hasuraMutation(mutation, variables);
  }
}

dynamic myEncode(dynamic item) {
  if (item is DateTime) {
    return item.toIso8601String();
  }
  return item;
}
