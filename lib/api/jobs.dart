import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:get/get.dart';

class JobsAPI {
  final HasuraService hasura = HasuraService.to;
  final ProfileAPI profileApi = ProfileAPI.to;

  Future fetchJobs() async {
    String query = """
      query MyQuery(\$id: Int!) {
        jobs(where: {facility_id: {_eq: \$id}}) {
          company_name
          id
          location
          title
        }
      }
    """;

    Map<String, dynamic> variables = {
      "id": profileApi.selectedChurchId,
    };

    var res = await hasura.hasuraQuery(query, variables);

    return res["data"]["jobs"];
  }

  Future fetchJobById(int id) async {
    String query = """
      query MyQuery(\$id: Int!) {
        jobs(where: {facility_id: {_eq: \$id}}) {
          company_name
          description
          email
          facility_id
          id
          link
          location
          member_id
          name
          phone_no
          title
        }
      }

    """;

    Map<String, dynamic> variables = {
      "id": profileApi.selectedChurchId,
    };

    var res = await hasura.hasuraQuery(query, variables);

    return res["data"]["jobs"][0];
  }

  Future deleteJob(int id) async {
    String mutation = """
      mutation MyMutation(\$id: Int!) {
        delete_jobs(where: {id: {_eq: \$id}}) {
          affected_rows
        }
      }

    """;

    Map<String, dynamic> variables = {"id": id};

    var res = await hasura.hasuraMutation(mutation, variables);
    print(res);
    Get.back();
  }

  Future postJob(
    String title,
    String location,
    String company,
    String phone,
    String description,
    bool membersOnly,
    String link,
  ) async {
    String mutation = """
      mutation MyMutation(\$visible_guest: Boolean!, \$title: String!, \$phone_no: String = "", \$name: String!, \$member_id: Int!, \$location: String!, \$link: String = "", \$facility_id: Int!, \$email: String!, \$description: String!, \$company_name: String!) {
        insert_jobs_one(object: {company_name: \$company_name, description: \$description, email: \$email, facility_id: \$facility_id, link: \$link, member_id: \$member_id, name: \$name, title: \$title, phone_no: \$phone_no, visible_guest: \$visible_guest, location: \$location}) {
          id
        }
      }
    """;

    Map<String, dynamic> variables = {
      "company_name": company,
      "description": description,
      "email": profileApi.email,
      "facility_id": profileApi.selectedChurchId,
      "link": link,
      "member_id": profileApi.memberId,
      "name": profileApi.name,
      "title": title,
      "phone_no": phone,
      "visible_guest": membersOnly,
      "location": location,
    };

    var res = await hasura.hasuraMutation(mutation, variables);
    print(res);
    Get.back();
  }
}
