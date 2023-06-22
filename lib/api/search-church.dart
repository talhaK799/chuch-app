import 'dart:convert';

import 'package:churchappenings/api/profile.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:churchappenings/utils/date-time-encode.dart';

class SearchChurchAPI {
  final HasuraService hasura = HasuraService.to;
  final ProfileAPI profileApi = ProfileAPI.to;

  Future<dynamic> fetchChurchByName(String searchquery) async {
    String query = """
      query MyQuery {
        facility(where: {_and: {is_verified: {_eq: "APPROVED"}, name: {_ilike: "%$searchquery%"}}}) {
          place_id
          name
          is_verified
          address
        }
      }
    """;

    var res = await hasura.hasuraConnectAnonymus.query(query);
    return res["data"]["facility"];
  }

  Future<dynamic> fetchChurchByCountry(String country) async {
    String query = """

  query MyQuery(\$country: String!) {
  facility(where: {country: {_eq: \$country}}) {
    id
    name
    address
    country
    created_at
    description
    }
  }
  """;

    Map<String, String> variables = {
      "country": country,
    };

    try {
      print(query);
      print(variables);
      var result = await hasura.hasuraQuery(query, variables);

      print(result);

      return result["data"]["facility"];
    } catch (error) {
      throw Exception("Error fetching facilities: $error");
    }
  }

  Future<dynamic> fetchChurchByPlaceID(String id) async {
    String query = """
      query MyQuery {
        facility(where: {_and: {is_verified: {_eq: "APPROVED"}, place_id: {_eq: "$id"}}}) {
          place_id
          name
          is_verified
          address
          id
        }
      }
    """;

    var res = await hasura.hasuraConnectAnonymus.query(query);
    return res["data"]["facility"];
  }

  Future visitChurch({
    required String phoneNumber,
    required int age,
    required String country,
    required String state,
    required String purpose,
    required DateTime dateTime,
    required bool requestCall,
    required int facilityId,
    required String churchAffiliation,
  }) async {
    String mutation = """
      mutation MyMutation(\$age: Int!, \$church_affiliation: String!, \$country: String!, \$date_of_visit: timestamptz!, \$description: String!, \$email: String!, \$name: String!, \$phone_no: String!, \$request_call: Boolean!, \$requested_facility_id: Int!, \$requester_member_id: Int!, \$state: String!) {
        insert_guestbook_one(object: {state: \$state, requester_member_id: \$requester_member_id, requested_facility_id: \$requested_facility_id, request_call: \$request_call, phone_no: \$phone_no, name: \$name, email: \$email, description: \$description, date_of_visit: \$date_of_visit, country: \$country, church_affiliation: \$church_affiliation, age: \$age}) {
          id
        }
      }
    """;

    Map<String, dynamic> variables = {
      "date_of_visit": json.encode(dateTime, toEncodable: dateTimeEncode),
      "phone_no": phoneNumber,
      "requester_member_id": profileApi.memberId!,
      "age": age,
      "church_affiliation": churchAffiliation,
      "country": country,
      "state": state,
      "description": purpose,
      "email": profileApi.email,
      "name": profileApi.name,
      "request_call": requestCall,
      "requested_facility_id": facilityId,
    };

    var res = await hasura.hasuraMutation(mutation, variables);
    print(res);
  }

  Future checkForUpcomingVisit(int facilityId) async {
    var todayNow = DateTime.now();

    String query = """
      query MyQuery(\$today: timestamptz!, \$id: Int!) {
        guestbook(where: {_and: {date_of_visit: {_gte: \$today}, requested_facility_id: {_eq: $facilityId}, requester_member_id: {_eq: \$id}}}) {
          date_of_visit
        }
      }
    """;

    Map<String, dynamic> variables = {
      "today": json.encode(todayNow, toEncodable: dateTimeEncode),
      "id": profileApi.memberId!
    };

    var res = await hasura.hasuraQuery(query, variables);
    print(res);

    return res["data"]["guestbook"];
  }
}
