import 'package:churchappenings/models/country_code.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AddChurchController extends GetxController {
  final log = Logger();
  late CountryAndTerritory selectedCountryAndTerritory;

  AddChurchController() {
    selectedCountryAndTerritory = countryAndTerritory[0];
  }

  selectCountry(CountryAndTerritory country) {
    selectedCountryAndTerritory = country;

    log.e(
        "@addchurchcontroller:Country country==>${selectedCountryAndTerritory.country} territory==>${selectedCountryAndTerritory.territory}");
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
        country: "Djibouti", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Eritrea", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Somalia", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Ethiopia", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Kenya", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Tanzania", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Uganda", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Rwanda", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Burundi", territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "South Sudan",
        territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Democratice Republic of Congo",
        territory: "East-Central Africa Division (ECD)"),
    CountryAndTerritory(
        country: "Armenia", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Belarus", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Georgia", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Kazakhstan", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Kyrgyzstan", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Moldova", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Russia", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Tajikistan", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Turkmenistan", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Ukraine", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Uzbekistan", territory: "Euro-Asia Division (ESD)"),
    CountryAndTerritory(
        country: "Mexico", territory: "Inter-American Division"),
    CountryAndTerritory(
        country: "Central America", territory: "Inter-American Division"),
    CountryAndTerritory(
        country: "Caribbean", territory: "Inter-American Division"),
    CountryAndTerritory(
        country: "Northern South America",
        territory: "Inter-American Division"),
  ];
}
