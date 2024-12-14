import 'package:get/get.dart';

class CountrySelectionController extends GetxController {
  String searchText = '';
  bool isClickOnCountry = false;
  String selectedCountry = '';
  String flag = '';

  void searchCountry(String value) {
    searchText = value;
    update();
  }

  void selectCountry(bool value, String country, String flagValue) {
    isClickOnCountry = value;
    selectedCountry = country;
    flag = flagValue;
    update();
  }
}

final List<Map<String, String>> countries = [
  {'name': 'United States', 'flag': '🇺🇸'},
  {'name': 'United Kingdom', 'flag': '🇬🇧'},
  {'name': 'Canada', 'flag': '🇨🇦'},
  {'name': 'Afghanistan', 'flag': '🇦🇫'},
  {'name': 'Albania', 'flag': '🇦🇱'},
  {'name': 'Algeria', 'flag': '🇩🇿'},
  {'name': 'Andorra', 'flag': '🇦🇩'},
  {'name': 'Angola', 'flag': '🇦🇴'},
  {'name': 'Argentina', 'flag': '🇦🇷'},
];
