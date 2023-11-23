import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/constants/strings.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:get/get.dart';

class StewardshipAPI {
  final ProfileAPI profileApi = ProfileAPI.to;
  final HasuraService hasura = HasuraService.to;

  Future createDonation(dynamic donationDeatils, int total, String actAs,
      String paymentType, String? periodId) async {
    int memberId = profileApi.memberId!;
    String query = """
      mutation MyMutation(\$member_id: Int!, \$facility_id: Int!, \$donation_details: jsonb!, \$donation_amount: Int!, \$act_as: String!, \$payment_type: String!, \$period_id: String!) {
        insert_stewardship(objects: {facility_id: \$facility_id, member_id: \$member_id, donation_amount: \$donation_amount, donation_details: \$donation_details, act_as: \$act_as, payment_type: \$payment_type, period_id: \$period_id}) {
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
      "act_as": actAs,
      "payment_type": paymentType,
      "period_id": periodId
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
    print('@getOwnDonarHistory');
    int memberId = profileApi.memberId!;
    String query = """
     query MyQuery {
  stewardship(where: {member_id: {_eq: $memberId}, act_as: {_eq: $donar}}, order_by: {date_time: desc}) {
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

  Future getOwnCollectorHistory() async {
    print("@getOwnCollectorHistory");
    int memberId = profileApi.memberId!;
    String query = """
    query MyQuery {
      stewardship(where: {member_id: {_eq: $memberId}, act_as: {_eq: $collector}}, order_by: {date_time: desc}) {
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

  Future getOwnCollectorCurrentPeriodHistory() async {
    print("@getOwnCollectorHistoryOfCurrentPeriod");
    int memberId = profileApi.memberId!;
    String periodId =
        "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

    String query = """
   query MyQuery(\$period_id: String!) {
  stewardship(where: {member_id: {_eq: $memberId}, act_as: {_eq: "collector"}, period_id: {_eq: \$period_id}, is_verified: {_eq: false}, is_current_period_ended: {_eq: false}}, order_by: {date_time: desc}) {
    donation_amount
    date_time
    is_verified
    receipt_url
    id
    act_as
    period_id
    payment_type
  }
}
    """;
    Map<String, dynamic> variables = {
      "period_id": periodId,
    };

    var res = await hasura.hasuraQuery(query, variables);
    return res["data"]["stewardship"];
  }

  Future getOwnDonationHistoryById(int id) async {
    print("@getDonatinoById $id");
    String query = """
      query MyQuery {
        stewardship(where: {id: {_eq: $id}}, order_by: {date_time: desc}) {
          donation_amount
          date_time
          is_verified
          receipt_url
          donation_details
          id
          facility_id
          payment_type
          act_as
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

  Future endCurrentPeriod(int id) async {
    print("UpdateCollection: $id");
    String mutation = """
    mutation MyMutation {
      update_stewardship(where: {id: {_eq: $id}}, _set: {is_current_period_ended: true}) {
        affected_rows
      }
    }
    """;
    // print(mutation);
    Map<String, dynamic> variables = {};
    var res = await hasura.hasuraMutation(mutation, variables);
    print(res);
    if (res["data"] != null) {
      return true;
    } else {
      return false;
    }
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
