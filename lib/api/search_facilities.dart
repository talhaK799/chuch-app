import 'dart:convert';

import '../models/facility.dart';
import '../services/hasura.dart';

class SearchFacilities {
  final HasuraService hasura = HasuraService.to;
  Future<dynamic> fetchFacilities(String country) async {
    String query = """

  query MyQuery(\$country: String!) {
  facility(where: {country: {_eq: \$country}}) {
    id
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
      var data = json.decode(result);
      var facilityData = data['data']['facility'];
      Facility facility = Facility.fromJson(facilityData[0]);
      print('Facility ID: ${facility.id}');

      return result["data"]["facility"];
      // List<Facility> facilities = (res['data']['facility'] as List)
      //     .map((facilityJson) => Facility.fromJson(facilityJson))
      //     .toList();
      // log("AA: ${facilities.}");
      // return facilities;

      // if (result != null && !result.hasException) {
      //   return result.data['facility'];
      // } else {
      //   throw Exception("Error fetching facilities");
      // }
    } catch (error) {
      throw Exception("Error fetching facilities: $error");
    }
  }
}
