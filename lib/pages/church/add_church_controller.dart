import 'package:churchappenings/api/upload-image.dart';
import 'package:churchappenings/models/add_church.dart';
import 'package:churchappenings/models/country_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AddChurchController extends GetxController {
  final log = Logger();
  late CountryAndTerritory selectedCountryAndTerritory;
  TextEditingController nameController = TextEditingController();
  TextEditingController noOfMembersController = TextEditingController();
  TextEditingController adminNameController = TextEditingController();
  TextEditingController adminEmailController = TextEditingController();
  TextEditingController adminPhoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  AddChurch addChurch = AddChurch();
  String? imagePath;
  String? uploadedImageUrl;

  AddChurchController() {
    selectedCountryAndTerritory = countryAndTerritory[0];
  }

  Future uploadEventImage() async {
    imagePath = await selectImage();
    update();
  }

  selectCountry(CountryAndTerritory country) {
    selectedCountryAndTerritory = country;
    log.e(
        "@addchurchcontroller:Country country==>${selectedCountryAndTerritory.country} territory==>${selectedCountryAndTerritory.territory}");
    update();
  }

  clearController() {
    nameController.clear();

    noOfMembersController.clear();
    adminNameController.clear();
    adminEmailController.clear();
    adminPhoneController.clear();
    addressController.clear();
    selectedCountryAndTerritory = countryAndTerritory[0];
    imagePath = null;
    uploadedImageUrl = null;
    update();
  }

  /////************************************************************/
  ///*************************************************************/
  ///  Country and Territory Constant List
  ///*************************************************************/
  ///*************************************************************/

  List<CountryAndTerritory> countryAndTerritory = [
    CountryAndTerritory(
        country: "Select Country", territory: "Select territory"),
    CountryAndTerritory(
        country: "Armenia", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Andorra", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Argentina", territory: "South American Division (SAD)"),
    CountryAndTerritory(
        country: "Austria", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Australia", territory: "South Pacific Division (SPD)"),
    CountryAndTerritory(
        country: "Angola",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Ascension Island",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Albania", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Bosnia-Herzegovina",
        territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Belgium", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Belarus", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Burundi", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "British / Bermuda",
        territory: "North American Division (NAD)"),
    CountryAndTerritory(
        country: "Benin", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Burkina Faso",
        territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Bolivia", territory: "South American Division (SAD)"),
    CountryAndTerritory(
        country: "Brazil", territory: "South American Division (SAD)"),
    CountryAndTerritory(
        country: "Bhutan", territory: "outhern Asia Division (SUD)"),
    CountryAndTerritory(
        country: "Bangladesh",
        territory: "Southern Asia-Pacific Division (SSD)"),
    CountryAndTerritory(
        country: "Brunei", territory: "Southern Asia-Pacific Division (SSD)"),
    CountryAndTerritory(
        country: "Burma", territory: "Southern Asia-Pacific Division (SSD)"),
    CountryAndTerritory(
        country: "Botswana",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Canada", territory: "North American Division (NAD)"),
    CountryAndTerritory(
        country: "Czech Republic", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "China", territory: "Northern Asia-Pacific Division (NSD)"),
    CountryAndTerritory(
        country: "Comoro Islands",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Central America", territory: "Inter-American Division"),
    CountryAndTerritory(
        country: "Caribbean", territory: "Inter-American Division"),
    CountryAndTerritory(
        country: "Cameroon", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Chile", territory: "South American Division (SAD)"),
    CountryAndTerritory(
        country: "Cape Verde", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Central African Republic",
        territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Chad", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Cambodia", territory: "Southern Asia-Pacific Division (SSD)"),
    CountryAndTerritory(
        country: "Channel Islands", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Croatia", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Cyprus", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Congo", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Democratice Republic of Congo",
        territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Denmark", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Djibouti", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Eritrea", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Ethiopia", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Ecuador", territory: "South American Division (SAD)"),
    CountryAndTerritory(
        country: "East Timor",
        territory: "Southern Asia-Pacific Division (SSD)"),
    CountryAndTerritory(
        country: "Equatorial Guinea",
        territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Estonia", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Faeroe Islands", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Finland", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "France/Kerguelen Islands",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "France", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "French / St. Pierre",
        territory: "North American Division (NAD)"),
    CountryAndTerritory(
        country: "French / Miquelon",
        territory: "North American Division (NAD)"),
    CountryAndTerritory(
        country: "Federated States of Micronesia",
        territory: "North American Division (NAD)"),
    CountryAndTerritory(
        country: "Georgia", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Germany", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Gilbraltar", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Greece", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Greenland", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Gabon", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Gambia", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Ghana", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Guinea", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Guinea-Bissau",
        territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Hungary", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Iceland", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Ireland", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Isle of Man", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Ivory Coast",
        territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Indonesia",
        territory: "Southern Asia-Pacific Division (SSD)"),
    CountryAndTerritory(
        country: "India", territory: "outhern Asia Division (SUD)"),
    CountryAndTerritory(
        country: "Italy", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Japan", territory: "Northern Asia-Pacific Division (NSD)"),
    CountryAndTerritory(
        country: "Kenya", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Kazakhstan", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Kyrgyzstan", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Lesbotho",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Laos", territory: "Southern Asia-Pacific Division (SSD)"),
    CountryAndTerritory(
        country: "Latvia", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Lithuania", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Liberia", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Liechtenstein", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Luxemburg", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Mali", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Mauritania", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Macedonia", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Montenegro", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Madagascar",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Malawi",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Malaysia", territory: "Southern Asia-Pacific Division (SSD)"),
    CountryAndTerritory(
        country: "Mauritius",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Mozambique",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Marshall Islands",
        territory: "North American Division (NAD)"),
    CountryAndTerritory(
        country: "Mexico", territory: "Inter-American Division"),
    CountryAndTerritory(
        country: "Moldova", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Malta", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Monaco", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Mongolia", territory: "Northern Asia-Pacific Division (NSD)"),
    CountryAndTerritory(
        country: "North Korea",
        territory: "Northern Asia-Pacific Division (NSD)"),
    CountryAndTerritory(
        country: "Namibia",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Northern South America",
        territory: "Inter-American Division"),
    CountryAndTerritory(
        country: "New Zealand", territory: "South Pacific Division (SPD)"),
    CountryAndTerritory(
        country: "New Zealand", territory: "South Pacific Division (SPD)"),
    CountryAndTerritory(
        country: "New Guinea", territory: "South Pacific Division (SPD)"),
    CountryAndTerritory(
        country: "Northern Mariana Islands",
        territory: "North American Division (NAD)"),
    CountryAndTerritory(
        country: "Nepal", territory: "outhern Asia Division (SUD)"),
    CountryAndTerritory(
        country: "Netherlands", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Norway", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Niger", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Nigeria", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Peru", territory: "South American Division (SAD)"),
    CountryAndTerritory(
        country: "Paraguay", territory: "South American Division (SAD)"),
    CountryAndTerritory(
        country: "Papua", territory: "South Pacific Division (SPD)"),
    CountryAndTerritory(
        country: "Pakistan", territory: "Southern Asia-Pacific Division (SSD)"),
    CountryAndTerritory(
        country: "Phillippines",
        territory: "Southern Asia-Pacific Division (SSD)"),
    CountryAndTerritory(
        country: "Portugal", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Poland", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Palau", territory: "North American Division (NAD)"),
    CountryAndTerritory(
        country: "Rwanda", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Réunion",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Russia", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Romania", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Somalia", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Serbia", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Slovenia", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Sweden", territory: "Trans-European Division (TED)"),
    CountryAndTerritory(
        country: "Senegal", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Sierra Leone",
        territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Singapore",
        territory: "Southern Asia-Pacific Division (SSD)"),
    CountryAndTerritory(
        country: "Sri Lanka",
        territory: "Southern Asia-Pacific Division (SSD)"),
    CountryAndTerritory(
        country: "St. Helen",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "São Tomé and Príncipe",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Seychelles",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "South Africa",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Swaziland",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "South Korea",
        territory: "Northern Asia-Pacific Division (NSD)"),
    CountryAndTerritory(
        country: "San Marino", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Slovakia", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Spain", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "Switzerland", territory: "Inter-European Division (EUD)"),
    CountryAndTerritory(
        country: "South Sudan",
        territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Tajikistan", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Turkmenistan", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Taiwan", territory: "Northern Asia-Pacific Division (NSD)"),
    CountryAndTerritory(
        country: "Thailand", territory: "Southern Asia-Pacific Division (SSD)"),
    CountryAndTerritory(
        country: "Togo", territory: "West-Central Africa Division (WAD)"),
    CountryAndTerritory(
        country: "Tanzania", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Uganda", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Ukraine", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Uzbekistan", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "United States / American",
        territory: "North American Division (NAD)"),
    CountryAndTerritory(
        country: "UK /Tristan da Cunha",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Uruguay", territory: "South American Division (SAD)"),
    CountryAndTerritory(
        country: "US/ Pacific of Guam",
        territory: "North American Division (NAD)"),
    CountryAndTerritory(
        country: "Vietnam", territory: "Southern Asia-Pacific Division (SSD)"),
    CountryAndTerritory(
        country: "Wake Islands", territory: "North American Division (NAD)"),
    CountryAndTerritory(
        country: "Zambia",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
    CountryAndTerritory(
        country: "Zimbabwe",
        territory: "Southern Africa-Indian Ocean Division (SID)"),
  ];
}
