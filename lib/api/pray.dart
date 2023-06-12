import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:get/get.dart';

class PrayAPI {
  final HasuraService hasura = HasuraService.to;
  final ProfileAPI profileApi = ProfileAPI.to;

  Future<dynamic> getPrayers(int offset) async {
    String query = """
      query MyQuery {
        prayer(
          limit: 20,
          offset: $offset,
          order_by: {created_at: desc}
          
          ) {
          facility_id
          global_community
          id
          is_anonymus
          mark_answered
          title
          created_at
          created_by
          description
        }
      }
    """;

    var result = await hasura.hasuraQuery(query);
    print(result);

    return result["data"]["prayer"];
  }

  Future addPray(int prayerId, String note) async {
    int memberId = profileApi.memberId!;
    String mutation = """
      mutation MyMutation(\$member_id: Int!, \$note: String!, \$prayer_id: Int!) {
        insert_prayer_note_one(object: {member_id: \$member_id, note: \$note, prayer_id: \$prayer_id}) {
          prayer_id
        }
      }
    """;

    Map<String, dynamic> variables = {
      "prayer_id": prayerId,
      "member_id": memberId,
      "note": note,
    };

    try {
      await hasura.hasuraMutation(mutation, variables);
      Get.snackbar(
        'Prayed successfully',
        'Success',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'You already have prayed',
        'Failed',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<dynamic> getOwnPrays(int offset) async {
    int memberId = profileApi.memberId!;
    String query = """
      query MyQuery(\$member_id: Int!) {
        prayer(
          limit: 20,
          offset: $offset,
          order_by: {created_at: desc},
          where: {created_by: {_eq: \$member_id}}
          ){
          
          description
          title
          mark_answered
          id
        }
      }

    """;

    Map<String, dynamic> variables = {
      "member_id": memberId,
    };

    var result = await hasura.hasuraQuery(query, variables);
    print(result["data"]["prayer"]);
    return result["data"]["prayer"];
  }

  Future togglePrayAsAnswered(bool updateStatus, int id) async {
    String mutation = """
      mutation MyMutation(\$mark_answered: Boolean!, \$id: Int!) {
        update_prayer(where: {id: {_eq: \$id}}, _set: {mark_answered: \$mark_answered}) {
          affected_rows
        }
      }
    """;

    Map<String, dynamic> variables = {"id": id, "mark_answered": updateStatus};

    var result = await hasura.hasuraMutation(mutation, variables);
    print(result);
  }

  Future<dynamic> getDetailsOfPrays(int id) async {
    String query = """
      query MyQuery(\$id: Int!) {
        prayer(where: {id: {_eq: \$id}}) {
          description
          id
          title
          prayer_notes {
            note
            member {
              user {
                name
              }
            }
          }
        }
      }

    """;

    Map<String, dynamic> variables = {
      "id": id,
    };

    var result = await hasura.hasuraQuery(query, variables);
    return result["data"]["prayer"][0];
  }

  Future createPray(
    bool isAnonymus,
    bool globalCommunity,
    String description,
    String title,
  ) async {
    int facilityId = profileApi.selectedChurchId;
    int memberId = profileApi.memberId!;

    String mutation = """
      mutation MyMutation(\$is_anonymus: Boolean!, \$global_community: Boolean!, \$facility_id: Int!, \$created_by: Int!, \$description: String!, \$title: String!) {
        insert_prayer(objects: {created_by: \$created_by, description: \$description, facility_id: \$facility_id, global_community: \$global_community, is_anonymus: \$is_anonymus, title: \$title}) {
          affected_rows
        }
      }
    """;

    Map<String, dynamic> variables = {
      "is_anonymus": isAnonymus,
      "global_community": globalCommunity,
      "facility_id": facilityId,
      "created_by": memberId,
      "description": description,
      "title": title,
    };

    var result = await hasura.hasuraMutation(mutation, variables);
    print(result);

    Get.back();
    Get.snackbar(
      'Prayer request created',
      '$title prayer requested successfully.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<double> getPrayrometerData() async {
    // String query = """
    //   query MyQuery(\$id: Int!) {
    //     facility(where: {id: {_eq: \$id}}) {
    //       prayers_aggregate {
    //         aggregate {
    //           count
    //         }
    //       }
    //       prayers {
    //         prayer_notes_aggregate {
    //           aggregate {
    //             count
    //           }
    //         }
    //       }
    //     }
    //   }

    // """;

    // Map<String, dynamic> variables = {
    //   "id": profileApi.selectedChurchId,
    // };

    // var result = await hasura.hasuraQuery(query, variables);

    // if (result["data"]["facility"][0]["prayers_aggregate"]["aggregate"]
    //         ["count"] ==
    //     0)
    //   return 0;
    // else if (result["data"]["facility"][0]["prayers_aggregate"]["aggregate"]
    //         ["count"] ==
    //     0) {
    //   return 80;
    // }

    return 80;
  }
}
