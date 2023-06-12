import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';

class SermonNotesAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future createNote(String title) async {
    String query = """
      mutation MyMutation(\$title: String!, \$member_id: Int!) {
        insert_sermon_notes_one(object: {member_id: \$member_id, title: \$title}) {
          id
        }
      }
    """;

    Map<String, dynamic> variables = {
      "title": title,
      "member_id": profileApi.memberId,
    };

    var res = await hasura.hasuraMutation(query, variables);

    return res["data"]["insert_sermon_notes_one"]["id"];
  }

  Future updateNote(int id, dynamic note) async {
    String query = """
      mutation MyMutation(\$id: Int!, \$data: jsonb!) {
        update_sermon_notes(where: {id: {_eq: \$id}}, _set: {data: \$data, no_data: false}) {
          affected_rows
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": id,
      "data": note,
    };

    await hasura.hasuraMutation(query, variables);
  }

  Future getNoteDetails(int id) async {
    String query = """
      query MyQuery(\$id: Int!) {
        sermon_notes(where: {id: {_eq: \$id}}) {
          id
          title
          data
          date
          no_data
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": id,
    };

    var res = await hasura.hasuraQuery(query, variables);

    return res["data"]["sermon_notes"][0];
  }

  Future getAllNotes() async {
    String query = """
      query MyQuery(\$id: Int!) {
        sermon_notes(order_by: {date: desc}, where: {member_id: {_eq: \$id}}) {
          id
          title
          data
          date
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": profileApi.memberId,
    };

    var res = await hasura.hasuraQuery(query, variables);

    return res["data"]["sermon_notes"];
  }

  Future deleteNote(int id) async {
    String query = """
      mutation MyMutation(\$id: Int!) {
        delete_sermon_notes(where: {id: {_eq: \$id}}) {
          affected_rows
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": id,
    };

    await hasura.hasuraMutation(query, variables);
  }

  Future getSearchedNotes(String squery) async {
    String search = "%" + squery + "%";
    String query = """
      query MyQuery(\$id: Int!, \$search: String!) {
        sermon_notes(order_by: {date: desc}, where: {title: {_ilike: \$search}, member_id: {_eq: \$id}}) {
          id
          title
          data
          date
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": profileApi.memberId,
      "search": search,
    };

    var res = await hasura.hasuraQuery(query, variables);

    return res["data"]["sermon_notes"];
  }
}
