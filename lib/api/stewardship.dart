import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:get/get.dart';

class StewardshipAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future createDonation(dynamic donationDeatils, int total) async {
    int memberId = profileApi.memberId!;
    String query = """
      mutation MyMutation(\$member_id: Int!, \$facility_id: Int!, \$donation_details: jsonb!, \$donation_amount: Int!) {
        insert_stewardship(objects: {facility_id: \$facility_id, member_id: \$member_id, donation_amount: \$donation_amount, donation_details: \$donation_details}) {
          affected_rows
          returning {
            id
          }
        }
      }
    """;

    Map<String, dynamic> variables = {
      "member_id": memberId,
      "facility_id": profileApi.selectedChurchId,
      "donation_amount": total,
      "donation_details": donationDeatils,
    };

    var res = await hasura.hasuraMutation(query, variables);
    print(res);
    return res["data"]["insert_stewardship"]["returning"][0]["id"];
  }

  Future payOnline(
    int facilityId,
    int total,
    int donationId,
  ) async {
    print("Play");
    String query = """
      mutation MyMutation(\$facility_id: Int!, \$email: String!, \$donation_id: Int!, \$amount: Int!) {
        create_stripe_session(amount: \$amount, donation_id: \$donation_id, email: \$email, facility_id: \$facility_id) {
          url
          status
          message
        }
      }
    """;

    Map<String, dynamic> variables = {
      "facility_id": profileApi.selectedChurchId,
      "amount": total,
      "donation_id": donationId,
      "email": profileApi.email,
    };

    var res = await hasura.hasuraMutation(query, variables);
    return res["data"]["create_stripe_session"];
  }

  Future getPreference() async {
    String query = """
      query MyQuery(\$uuid: String!) {
        user(where: {uuid: {_eq: \$uuid}}) {
          donation_details
        }
      }
      """;

    Map<String, dynamic> variables = {"uuid": profileApi.uuid};
    var res = await hasura.hasuraQuery(query, variables);

    return res["data"]["user"][0]["donation_details"];
  }

  Future updatePreference(dynamic donationDetails) async {
    String query = """
     mutation MyMutation(\$donation_details: jsonb!, \$uuid: String!) {
          update_user(where: {uuid: {_eq: \$uuid}}, _set: {donation_details: \$donation_details}) {
            affected_rows
          }
        }
      """;

    Map<String, dynamic> variables = {
      "uuid": profileApi.uuid,
      "donation_details": donationDetails
    };
    await hasura.hasuraMutation(query, variables);
    Get.back();
  }

  Future getOwnDonationHistory() async {
    int memberId = profileApi.memberId!;
    String query = """
      query MyQuery {
        stewardship(where: {member_id: {_eq: $memberId}}) {
          donation_amount
          date_time
          is_verified
          receipt_url
          id
        }
      }
    """;

    var res = await hasura.hasuraQuery(query);
    return res["data"]["stewardship"];
  }

  Future getDonationHistory() async {
    String query = """
      query MyQuery {
        stewardship {
          donation_amount
          date_time
          is_verified
          receipt_url
          id
        }
      }
    """;

    var res = await hasura.hasuraQuery(query);
    return res["data"]["stewardship"];
  }

  Future getOwnDonationHistoryById(int id) async {
    String query = """
      query MyQuery {
        stewardship(where: {id: {_eq: $id}}) {
          donation_amount
          date_time
          is_verified
          receipt_url
          donation_details
          id
          facility_id
          member {
            user {
              name
              email
            }
          }
        }
      }
    """;

    var res = await hasura.hasuraQuery(query);
    return res["data"]["stewardship"][0];
  }

  Future deleteById(int id) async {
    String mutation = """
      mutation MyMutation(\$id: Int!) {
        delete_stewardship(where: {id: {_eq: \$id}}) {
          affected_rows
        }
      }
    """;

    Map<String, dynamic> variables = {"id": id};

    var res = await hasura.hasuraMutation(mutation, variables);
    return res["data"]["stewardship"][0];
  }

  Future getDonationPrefrenceForCHurchId(int churchId) async {
    String query = """
      query MyQuery {
        stewardship_options(where: {facility_id: {_eq: $churchId}}) {
          option
        }
      }
    """;

    var res = await hasura.hasuraQuery(query);
    return res["data"]["stewardship_options"];
  }

  Future verifyById(int id) async {
    String mutation = """
      mutation MyMutation(\$id: Int!) {
        update_stewardship(where: {id: {_eq: \$id}}, _set: {is_verified: true}) {
          affected_rows
        }
      }
    """;

    Map<String, dynamic> variables = {"id": id};

    var res = await hasura.hasuraMutation(mutation, variables);
    return res["data"]["stewardship"][0];
  }
}
