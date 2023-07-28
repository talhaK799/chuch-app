import 'dart:convert';

import 'package:churchappenings/models/poll.dart';
import 'package:churchappenings/services/hasura.dart';

class PollAPI {
  final HasuraService hasura = HasuraService.to;

  Future<List<PollModel>?> fetchPolls() async {
    List<PollModel> data = [];

    try {
      String query = """
          query MyQuery {
            polling(where: {_and: {is_archived: {_eq: false}, is_upcoming: {_eq: false}}}) {
              id
              title
              desc
              options
              user_pols {
                selected_option
              }
            }
          }
        """;
      var res = await hasura.hasuraQuery(query);

      data = pollModelFromJson(json.encode(res["data"]["polling"]));
      print("@poll response==>>>>>>${data[0].toJson()}");

      print(data);
    } catch (e) {
      print(e);
    }

    return data;
  }

  Future<int> fetchNoOfPolls() async {
    int count = 0;

    try {
      String query = """
          query MyQuery {
            polling_aggregate(where: {_and: {is_archived: {_eq: false}, is_upcoming: {_eq: false}}}) {
              aggregate {
                count(columns: id)
              }
            }
          }
        """;
      var res = await hasura.hasuraQuery(query);

      count = res["data"]["polling_aggregate"]["aggregate"]["count"];
    } catch (e) {
      print(e);
    }

    return count;
  }

  Future addvote(int pollId, String selectedOption) async {
    try {
      String query = """
        query MyQuery {
          member {
            id
          }
        }
      """;

      var res = await hasura.hasuraQuery(query);

      String mutation = """
        mutation MyMutation(\$poll_id: Int!, \$member_id: Int!, \$selected_option: String!) {
          insert_user_pols_one(object: {member_id: \$member_id, selected_option: \$selected_option, poll_id: \$poll_id}) {
            poll_id
            selected_option
            member {
              user {
                uuid
              }
            }
          }
        }
      """;

      Map<String, dynamic> variables = {
        "poll_id": pollId,
        "member_id": res["data"]["member"][0]["id"],
        "selected_option": selectedOption,
      };

      await hasura.hasuraMutation(mutation, variables);
    } catch (e) {}
  }
}
