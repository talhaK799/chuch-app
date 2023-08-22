import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/models/add_church.dart';
import 'package:churchappenings/services/hasura.dart';

class ChurchApi {
  final HasuraService hasura = HasuraService.to;
  final ProfileAPI profileApi = ProfileAPI.to;

  Future addChurch(AddChurch addChurch, double lat, double lng) async {
    try {
      String mutation = """
      mutation MyMutation(
        \$church_name: String!,
        \$admin_name: String!,
        \$admin_email: String!,
        \$address: String!,
        \$mode: String!,
        \$no_members: Int!,
        \$place_id: String!,
        \$division: String!,
        \$country: String!,
        \$territory: String!,
        \$logo: String!,
        \$lat: Float!,
        \$lng: Float!
      ) {
        create_church(
          church_name: \$church_name,
          admin_name: \$admin_name,
          admin_email: \$admin_email,
          address: \$address,
          location: {lat: \$lat, lng: \$lng},
          mode: \$mode,
          no_members: \$no_members,
          place_id: \$place_id,
          division: \$division,
          country: \$country,
          territory: \$territory,
          plan_data: {coupon_id: "", price_id: ""},
          logo: \$logo
        ) {
          message
          status
        }
      }
    """;

      Map<String, dynamic> variables = {
        "church_name": addChurch.name,
        "admin_name": addChurch.adminName,
        "admin_email": addChurch.adminEmail,
        "address": addChurch.address,
        "mode": addChurch.mode,
        "no_members": addChurch.noOfMembers,
        "place_id": addChurch.placeId,
        "division": addChurch.division,
        "country": addChurch.country,
        "territory": addChurch.territory,
        "logo": addChurch.logo,
        "lat": lat, // Pass latitude as a variable
        "lng": lng, // Pass longitude as a variable
      };

      var res = await hasura.hasuraMutation(mutation, variables);
      print("church respons==========>$res");
    } catch (e) {
      print("Error: $e");
    }
  }

//   Future addChurch(AddChurch addChurch, double lat, double lng) async {
//     try {
//       String mutation = """
// mutation MyMutation(\$church_name: String!, \$admin_name: String!, \$admin_email: String!, \$address: String!, \$mode: String!, \$no_members: Int!, \$place_id: String!, \$division: String!, \$country: String!, \$territory: String!, \$logo: String!) {
//         create_church(
//             church_name: \$church_name,
//             admin_name: \$admin_name,
//             admin_email: \$admin_email,
//             address:\$address,
//             location: {"lat": $lat, "lng": $lng},
//             mode: \$mode,
//             no_members: \$no_members,
//             place_id: \$place_id,
//             division: \$division,
//             country: \$country,
//             territory: \$territory,
//             plan_data: {coupon_id: "", price_id: ""},
//             logo: \$logo
//         ){
//           message
//           status
//         }
//     }
//   """;
//       print(mutation);

//       Map<String, dynamic> variables = {
//         "church_name": addChurch.name,
//         "admin_name": addChurch.adminName,
//         "admin_email": addChurch.adminEmail,
//         "address": addChurch.address,
//         "mode": addChurch.mode,
//         "no_members": addChurch.noOfMembers,
//         "place_id": addChurch.placeId,
//         "division": addChurch.division,
//         "country": addChurch.country,
//         "territory": addChurch.territory,
//         "logo": addChurch.logo,
//       };

//       var res = await hasura.hasuraMutation(mutation, variables);
//       print("church respons==========>$res");
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
}
