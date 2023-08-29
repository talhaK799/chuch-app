import 'dart:convert';
import 'package:churchappenings/constants/api.dart';
import 'package:churchappenings/services/hasura.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:http/http.dart' as http;
import 'package:churchappenings/api/church.dart';
import 'package:churchappenings/api/google.dart';
import 'package:churchappenings/api/upload-image.dart';
import 'package:churchappenings/models/add_church.dart';
import 'package:churchappenings/models/country_code.dart';
import 'package:churchappenings/models/location.dart';
import 'package:churchappenings/models/prediction.dart';
import 'package:churchappenings/utils/map_response.dart';
import 'package:churchappenings/utils/prediction_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart' as Loc;
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

class AddChurchController extends GetxController {
  final log = Logger();

  late CountryAndDivision selectedCountryAndDivision;
  TextEditingController nameController = TextEditingController();
  TextEditingController noOfMembersController = TextEditingController();
  TextEditingController adminNameController = TextEditingController();
  TextEditingController adminEmailController = TextEditingController();
  TextEditingController adminPhoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController territoryController = TextEditingController();
  AddChurch addChurch = AddChurch();
  LatLng? latLng;
  String? imagePath;
  String? uploadedImageUrl;
  Position? position;
  Uuid uuid = Uuid();
  LatLng? currentLocation;
  late PrdicutionResponse prdicutionResponse;
  List<Predicution> predictions = [];
  late MapResponse mapResponse;
  LatLng? selectedLocation;
  String? fromlongitude;
  String? fromlatitude;
  List<String> listOfLats = [];
  List<String> listOfLongs = [];
  ChurchApi churchApi = ChurchApi();
  CustomLocation? customLocation = CustomLocation();
  late HasuraConnect hasuraConnect;

  AddChurchController() {
    selectedCountryAndDivision = countryAndDivisions[0];
  }

  Future uploadEventImage() async {
    imagePath = await selectImage();
    update();
  }

  getCurrentLocation() async {
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    currentLocation = LatLng(position!.latitude, position!.longitude);

    String address = await getAddressFromLatLng(Loc.Location(
        lat: currentLocation!.latitude, lng: currentLocation!.longitude));
    addressController.text = address;

    print("Cureent Location is $currentLocation");
    update();
  }

  Future<Map<String, double>?> getLatLngFromAddress(
      String address, String apiKey) async {
    final queryParameters = {
      'address': address,
      'key': apiKey,
    };

    final uri = Uri.https(
        'maps.googleapis.com', '/maps/api/geocode/json', queryParameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final results = jsonResponse['results'] as List<dynamic>;

      if (results.isNotEmpty) {
        final location = results[0]['geometry']['location'];
        final double latitude = location['lat'];
        final double longitude = location['lng'];

        return {'latitude': latitude, 'longitude': longitude};
      }
    }

    return null; // If the request fails or no coordinates are found
  }

  getLatitudeAndLongnitudeFromAdd(
    String address,
  ) async {
    Map<String, double>? coordinates =
        await getLatLngFromAddress(address, EndPoints.googleApiKey);

    if (coordinates != null) {
      double latitude = coordinates['latitude']!;
      double longitude = coordinates['longitude']!;

      currentLocation = LatLng(latitude, longitude);
    } else {
      print('Coordinates not found.');
    }
    update();
  }

  Future<String> getAddressFromLatLng(Loc.Location location) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.lat!, location.lng!);

      Placemark place = placemarks[0];

      print("the location is  ${place.thoroughfare} " +
          " ${place.subLocality}" +
          " ${place.locality}" +
          " ${place.country}");
      return "${place.thoroughfare} ${place.subLocality} ${place.locality} ${place.country}";
    } catch (e) {
      print("the exception is $e");
      return '';
    }
  }

  prediction() async {
    prdicutionResponse = await getPreduction(addChurch.address!);
    prdicutionResponse.predicutions.forEach((element) {
      this.predictions.add(element);
    });
  }

  getLocationDetails(String placeId) async {
    String request =
        '${EndPoints.detailLocation}?placeid=$placeId&key=${EndPoints.googleApiKey}';

    var response = await Dio().get(request);

    if (response.statusCode == 200) {
      return MapResponse.fromJson(response.data);
    }
  }

  searchPickUpLocation(String val) async {
    predictions.clear();
    prdicutionResponse = await getPreduction(val.trim());
    prdicutionResponse.predicutions.forEach((element) {
      this.predictions.add(element);
    });

    update();
  }

  getSearchedLocationDetails(String placeId, index) async {
    mapResponse = await getLocationDetails(placeId);

    if (mapResponse.mapAddress!.latitude != null) {
      if (true) {
        addChurch.address = predictions[index].address;
        selectedLocation = LatLng(mapResponse.mapAddress!.latitude!,
            mapResponse.mapAddress!.longnitude!);
        fromlatitude = mapResponse.mapAddress!.latitude!.toString();
        fromlongitude = mapResponse.mapAddress!.longnitude!.toString();

        addressController.text = predictions[index].address!;
        // addChurch.location!.lat = mapResponse.mapAddress!.latitude!;
        // addChurch.location!.lng = mapResponse.mapAddress!.longnitude!;
        print("Address => ${predictions[index].address}");
        predictions.clear();
      }
    }

    update();
  }

  selectCountry(CountryAndDivision country) {
    selectedCountryAndDivision = country;

    update();
  }

  ///prediction
  getPreduction(String input) async {
    String requestUrl =
        '${EndPoints.baseURLForMap}?input=$input&key=${EndPoints.googleApiKey}&sessiontoken=${uuid.v4()}';
    var response = await Dio().get(requestUrl);
    if (response.statusCode == 200) {
      return PrdicutionResponse.fromJson(response.data);
    }
  }

  getPlaceId(double lat, double log) async {
    String request =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$log&key=${EndPoints.googleApiKey}';

    var response = await Dio().get(request);
    if (response.statusCode == 200) {
      print("placeId  ==>>${response.data["results"][0]["place_id"]}");
      addChurch.placeId = response.data["results"][0]["place_id"];
    }
    update();
  }

  createChurch() async {
    final HasuraService hasura = HasuraService.to;
    await hasura.unAuthenticationConnection();
    addChurch.country = selectedCountryAndDivision.country;
    addChurch.division = selectedCountryAndDivision.devision;
    addChurch.address = addressController.text;
    addChurch.territory = territoryController.text;
    addChurch.mode = 'test';

    // addChurch.location?.lat = currentLocation!.latitude;
    // addChurch.location?.lng = currentLocation!.longitude;
    // currentLocation != null
    // ?
    if (addressController.text.isNotEmpty) {
      await getLatitudeAndLongnitudeFromAdd(addressController.text);
    }
    currentLocation != null
        ? await getPlaceId(
            currentLocation!.latitude, currentLocation!.longitude)
        : await getPlaceId(position!.latitude, position!.longitude);
    // : getPlaceId(position!.latitude, position!.longitude);

    if (imagePath != null) {
      // uploadedImageUrl = await uploadImage(imagePath!);
      if (uploadedImageUrl != null) {
        addChurch.logo = uploadedImageUrl;
      }
    }
    customLocation != null
        ? await churchApi.addChurch(
            addChurch, currentLocation!.latitude, currentLocation!.longitude)
        : await churchApi.addChurch(
            addChurch, position!.latitude, position!.longitude);

    // log.i("church ==>>${addChurch.toJson()}}");
    // log.i("placeId  ==>>$place}");
  }

  clearController() {
    nameController.clear();
    territoryController.clear();
    noOfMembersController.clear();
    adminNameController.clear();
    adminEmailController.clear();
    adminPhoneController.clear();
    addressController.clear();

    selectedCountryAndDivision = countryAndDivisions[0];
    imagePath = null;
    uploadedImageUrl = null;
    update();
  }

  /////************************************************************/
  ///*************************************************************/
  ///  Country and Territory Constant List
  ///*************************************************************/
  ///*************************************************************/

  List<CountryAndDivision> countryAndDivisions = [
    CountryAndDivision(country: "Select Country", devision: "Select territory"),
    CountryAndDivision(
        country: "Armenia", devision: "Euro-Asia Division (ESD)"),
    CountryAndDivision(
        country: "Andorra", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Argentina", devision: "South American Division (SAD)"),
    CountryAndDivision(
        country: "Austria", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Australia", devision: "South Pacific Division (SPD)"),
    CountryAndDivision(
        country: "Angola",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "Ascension Island",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "Albania", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Bosnia-Herzegovina",
        devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Belgium", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Belarus", devision: "Euro-Asia Division (ESD)"),
    CountryAndDivision(
        country: "Burundi", devision: "East-Central Africa Division (ECD)"),
    CountryAndDivision(
        country: "British / Bermuda",
        devision: "North American Division (NAD)"),
    CountryAndDivision(
        country: "Benin", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Burkina Faso",
        devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Bolivia", devision: "South American Division (SAD)"),
    CountryAndDivision(
        country: "Brazil", devision: "South American Division (SAD)"),
    CountryAndDivision(
        country: "Bhutan", devision: "outhern Asia Division (SUD)"),
    CountryAndDivision(
        country: "Bangladesh",
        devision: "Southern Asia-Pacific Division (SSD)"),
    CountryAndDivision(
        country: "Brunei", devision: "Southern Asia-Pacific Division (SSD)"),
    CountryAndDivision(
        country: "Burma", devision: "Southern Asia-Pacific Division (SSD)"),
    CountryAndDivision(
        country: "Botswana",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "Canada", devision: "North American Division (NAD)"),
    CountryAndDivision(
        country: "Czech Republic", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "China", devision: "Northern Asia-Pacific Division (NSD)"),
    CountryAndDivision(
        country: "Comoro Islands",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "Central America", devision: "Inter-American Division"),
    CountryAndDivision(
        country: "Caribbean", devision: "Inter-American Division"),
    CountryAndDivision(
        country: "Cameroon", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Chile", devision: "South American Division (SAD)"),
    CountryAndDivision(
        country: "Cape Verde", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Central African Republic",
        devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Chad", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Cambodia", devision: "Southern Asia-Pacific Division (SSD)"),
    CountryAndDivision(
        country: "Channel Islands", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Croatia", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Cyprus", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Congo", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Democratice Republic of Congo",
        devision: "East-Central Africa Division (ECD)"),
    CountryAndDivision(
        country: "Denmark", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Djibouti", devision: "East-Central Africa Division (ECD)"),
    CountryAndDivision(
        country: "Eritrea", devision: "East-Central Africa Division (ECD)"),
    CountryAndDivision(
        country: "Ethiopia", devision: "East-Central Africa Division (ECD)"),
    CountryAndDivision(
        country: "Ecuador", devision: "South American Division (SAD)"),
    CountryAndDivision(
        country: "East Timor",
        devision: "Southern Asia-Pacific Division (SSD)"),
    CountryAndDivision(
        country: "Equatorial Guinea",
        devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Estonia", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Faeroe Islands", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Finland", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "France/Kerguelen Islands",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "France", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "French / St. Pierre",
        devision: "North American Division (NAD)"),
    CountryAndDivision(
        country: "French / Miquelon",
        devision: "North American Division (NAD)"),
    CountryAndDivision(
        country: "Federated States of Micronesia",
        devision: "North American Division (NAD)"),
    CountryAndDivision(
        country: "Georgia", devision: "Euro-Asia Division (ESD)"),
    CountryAndDivision(
        country: "Germany", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Gilbraltar", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Greece", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Greenland", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Gabon", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Gambia", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Ghana", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Guinea", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Guinea-Bissau",
        devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Hungary", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Iceland", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Ireland", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Isle of Man", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Ivory Coast", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Indonesia", devision: "Southern Asia-Pacific Division (SSD)"),
    CountryAndDivision(
        country: "India", devision: "outhern Asia Division (SUD)"),
    CountryAndDivision(
        country: "Italy", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Japan", devision: "Northern Asia-Pacific Division (NSD)"),
    CountryAndDivision(
        country: "Kenya", devision: "East-Central Africa Division (ECD)"),
    CountryAndDivision(
        country: "Kazakhstan", devision: "Euro-Asia Division (ESD)"),
    CountryAndDivision(
        country: "Kyrgyzstan", devision: "Euro-Asia Division (ESD)"),
    CountryAndDivision(
        country: "Lesbotho",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "Laos", devision: "Southern Asia-Pacific Division (SSD)"),
    CountryAndDivision(
        country: "Latvia", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Lithuania", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Liberia", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Liechtenstein", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Luxemburg", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Mali", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Mauritania", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Macedonia", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Montenegro", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Madagascar",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "Malawi",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "Malaysia", devision: "Southern Asia-Pacific Division (SSD)"),
    CountryAndDivision(
        country: "Mauritius",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "Mozambique",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "Marshall Islands", devision: "North American Division (NAD)"),
    CountryAndDivision(country: "Mexico", devision: "Inter-American Division"),
    CountryAndDivision(
        country: "Moldova", devision: "Euro-Asia Division (ESD)"),
    CountryAndDivision(
        country: "Malta", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Monaco", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Mongolia", devision: "Northern Asia-Pacific Division (NSD)"),
    CountryAndDivision(
        country: "North Korea",
        devision: "Northern Asia-Pacific Division (NSD)"),
    CountryAndDivision(
        country: "Namibia",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "Northern South America", devision: "Inter-American Division"),
    CountryAndDivision(
        country: "New Zealand", devision: "South Pacific Division (SPD)"),
    CountryAndDivision(
        country: "New Zealand", devision: "South Pacific Division (SPD)"),
    CountryAndDivision(
        country: "New Guinea", devision: "South Pacific Division (SPD)"),
    CountryAndDivision(
        country: "Northern Mariana Islands",
        devision: "North American Division (NAD)"),
    CountryAndDivision(
        country: "Nepal", devision: "outhern Asia Division (SUD)"),
    CountryAndDivision(
        country: "Netherlands", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Norway", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Niger", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Nigeria", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Peru", devision: "South American Division (SAD)"),
    CountryAndDivision(
        country: "Paraguay", devision: "South American Division (SAD)"),
    CountryAndDivision(
        country: "Papua", devision: "South Pacific Division (SPD)"),
    CountryAndDivision(
        country: "Pakistan", devision: "Southern Asia-Pacific Division (SSD)"),
    CountryAndDivision(
        country: "Phillippines",
        devision: "Southern Asia-Pacific Division (SSD)"),
    CountryAndDivision(
        country: "Portugal", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Poland", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Palau", devision: "North American Division (NAD)"),
    CountryAndDivision(
        country: "Rwanda", devision: "East-Central Africa Division (ECD)"),
    CountryAndDivision(
        country: "Réunion",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(country: "Russia", devision: "Euro-Asia Division (ESD)"),
    CountryAndDivision(
        country: "Romania", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Somalia", devision: "East-Central Africa Division (ECD)"),
    CountryAndDivision(
        country: "Serbia", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Slovenia", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Sweden", devision: "Trans-European Division (TED)"),
    CountryAndDivision(
        country: "Senegal", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Sierra Leone",
        devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Singapore", devision: "Southern Asia-Pacific Division (SSD)"),
    CountryAndDivision(
        country: "Sri Lanka", devision: "Southern Asia-Pacific Division (SSD)"),
    CountryAndDivision(
        country: "St. Helen",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "São Tomé and Príncipe",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "Seychelles",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "South Africa",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "Swaziland",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "South Korea",
        devision: "Northern Asia-Pacific Division (NSD)"),
    CountryAndDivision(
        country: "San Marino", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Slovakia", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Spain", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "Switzerland", devision: "Inter-European Division (EUD)"),
    CountryAndDivision(
        country: "South Sudan", devision: "East-Central Africa Division (ECD)"),
    CountryAndDivision(
        country: "Tajikistan", devision: "Euro-Asia Division (ESD)"),
    CountryAndDivision(
        country: "Turkmenistan", devision: "Euro-Asia Division (ESD)"),
    CountryAndDivision(
        country: "Taiwan", devision: "Northern Asia-Pacific Division (NSD)"),
    CountryAndDivision(
        country: "Thailand", devision: "Southern Asia-Pacific Division (SSD)"),
    CountryAndDivision(
        country: "Togo", devision: "West-Central Africa Division (WAD)"),
    CountryAndDivision(
        country: "Tanzania", devision: "East-Central Africa Division (ECD)"),
    CountryAndDivision(
        country: "Uganda", devision: "East-Central Africa Division (ECD)"),
    CountryAndDivision(
        country: "Ukraine", devision: "Euro-Asia Division (ESD)"),
    CountryAndDivision(
        country: "Uzbekistan", devision: "Euro-Asia Division (ESD)"),
    CountryAndDivision(
        country: "United States / American",
        devision: "North American Division (NAD)"),
    CountryAndDivision(
        country: "UK /Tristan da Cunha",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "Uruguay", devision: "South American Division (SAD)"),
    CountryAndDivision(
        country: "US/ Pacific of Guam",
        devision: "North American Division (NAD)"),
    CountryAndDivision(
        country: "Vietnam", devision: "Southern Asia-Pacific Division (SSD)"),
    CountryAndDivision(
        country: "Wake Islands", devision: "North American Division (NAD)"),
    CountryAndDivision(
        country: "Zambia",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndDivision(
        country: "Zimbabwe",
        devision: "Southern Africa-Indian Ocean Division (SID)"),
  ];
}
