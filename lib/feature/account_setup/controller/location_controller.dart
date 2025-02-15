// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/feature/account_setup/controller/city_controller.dart';
import 'package:unforgettable_getaway/feature/account_setup/controller/country_selection_controller.dart';

class LocationController extends GetxController {
  final selectCityController = Get.put(CityController());
  final selectCountry = Get.put(CountrySelectionController());
  var country = "".obs;
  var city = "".obs;
  var flag = "".obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLocationForIOS();
    // getCurrentLocation();
    // getAddressFromCoordinates();
  }

  Future<void> fetchLocationForIOS() async {
    if (Platform.isIOS) {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        debugPrint('Location services are disabled.');
        return;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied.');
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        debugPrint('Location permissions are permanently denied.');
        return;
      }

      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        latitude.value = position.latitude;
        longitude.value = position.longitude;

        debugPrint('Latitude: ${latitude.value}');
        debugPrint('Longitude: ${longitude.value}');

        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);

        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          country.value = placemark.country ?? "Unknown";
          city.value = placemark.locality ?? "Unknown";
          flag.value = countryToEmoji(country.value);
          selectCityController.selectedCity.value = city.value;
          selectCountry.selectedCountry.value = country.value;
          selectCountry.flag.value = flag.value;
        debugPrint("========>>>>>>${selectCityController.selectedCity.value}");
        debugPrint("========>>>>>${selectCountry.selectedCountry.value}");
        debugPrint("========>>>>>${selectCountry.flag}");
        debugPrint("========>>>>>>$latitude");
        debugPrint("========>>>>>>$longitude");
          Get.toNamed(AppRoute.namebirthScreen);
        } else {
          debugPrint('No placemarks found for the location.');
        }
      } catch (e) {
        debugPrint('Error fetching location: $e');
      }
    } else {
      debugPrint('This function is designed to run on iOS only.');
    }
  }

  Future<bool> checkLocationServices() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.defaultDialog(
        title: "Location Services Disabled",
        middleText: "Please enable location services to use this feature.",
        confirm: ElevatedButton(
          onPressed: () async {
            await Geolocator.openLocationSettings();
            Get.back();
          },
          child: const Text("Enable"),
        ),
        cancel: ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text("Cancel"),
        ),
      );
    }
    return serviceEnabled;
  }

  Future<Position> getCurrentLocation() async {
    debugPrint("================FunctionCalled");
    bool serviceEnabled = await checkLocationServices();
    if (!serviceEnabled) {
      debugPrint("Your Location Service disable");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Permission Denied",
          "Location permission is required to proceed.",
          snackPosition: SnackPosition.BOTTOM,
        );
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Permission Denied Forever",
        "Please enable location permissions from app settings.",
        snackPosition: SnackPosition.BOTTOM,
      );
      throw Exception(
          'Location permissions are permanently denied. We cannot request permissions.');
    }

    Get.toNamed(AppRoute.namebirthScreen);

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromCoordinates() async {
    try {
      isLoading.value = true;

      Position position = await getCurrentLocation();
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        country.value = place.country ?? "Unknown";
        city.value = place.locality ?? "Unknown";
        flag.value = countryToEmoji(country.value);
      } else {
        throw Exception('No address found.');
      }
    } catch (e) {
      debugPrint('Error fetching location: $e');
    } finally {
      selectCityController.selectedCity.value = city.value;
      selectCountry.selectedCountry.value = country.value;
      selectCountry.flag.value = flag.value;
      
      isLoading.value = false;
    }
  }

  String countryToEmoji(String countryName) {
    const countryCodes = {
      'Afghanistan': 'AF',
      'Albania': 'AL',
      'Algeria': 'DZ',
      'Andorra': 'AD',
      'Angola': 'AO',
      'Argentina': 'AR',
      'Armenia': 'AM',
      'Australia': 'AU',
      'Austria': 'AT',
      'Azerbaijan': 'AZ',
      'Bahamas': 'BS',
      'Bahrain': 'BH',
      'Bangladesh': 'BD',
      'Barbados': 'BB',
      'Belarus': 'BY',
      'Belgium': 'BE',
      'Belize': 'BZ',
      'Benin': 'BJ',
      'Bhutan': 'BT',
      'Bolivia': 'BO',
      'Bosnia and Herzegovina': 'BA',
      'Botswana': 'BW',
      'Brazil': 'BR',
      'Brunei': 'BN',
      'Bulgaria': 'BG',
      'Burkina Faso': 'BF',
      'Burundi': 'BI',
      'Cambodia': 'KH',
      'Cameroon': 'CM',
      'Canada': 'CA',
      'Cape Verde': 'CV',
      'Central African Republic': 'CF',
      'Chad': 'TD',
      'Chile': 'CL',
      'China': 'CN',
      'Colombia': 'CO',
      'Comoros': 'KM',
      'Congo (Congo-Brazzaville)': 'CG',
      'Congo (Democratic Republic)': 'CD',
      'Costa Rica': 'CR',
      'Croatia': 'HR',
      'Cuba': 'CU',
      'Cyprus': 'CY',
      'Czech Republic': 'CZ',
      'Denmark': 'DK',
      'Djibouti': 'DJ',
      'Dominica': 'DM',
      'Dominican Republic': 'DO',
      'Ecuador': 'EC',
      'Egypt': 'EG',
      'El Salvador': 'SV',
      'Equatorial Guinea': 'GQ',
      'Eritrea': 'ER',
      'Estonia': 'EE',
      'Eswatini': 'SZ',
      'Ethiopia': 'ET',
      'Fiji': 'FJ',
      'Finland': 'FI',
      'France': 'FR',
      'Gabon': 'GA',
      'Gambia': 'GM',
      'Georgia': 'GE',
      'Germany': 'DE',
      'Ghana': 'GH',
      'Greece': 'GR',
      'Grenada': 'GD',
      'Guatemala': 'GT',
      'Guinea': 'GN',
      'Guinea-Bissau': 'GW',
      'Guyana': 'GY',
      'Haiti': 'HT',
      'Honduras': 'HN',
      'Hungary': 'HU',
      'Iceland': 'IS',
      'India': 'IN',
      'Indonesia': 'ID',
      'Iran': 'IR',
      'Iraq': 'IQ',
      'Ireland': 'IE',
      'Israel': 'IL',
      'Italy': 'IT',
      'Jamaica': 'JM',
      'Japan': 'JP',
      'Jordan': 'JO',
      'Kazakhstan': 'KZ',
      'Kenya': 'KE',
      'Kiribati': 'KI',
      'Korea (North)': 'KP',
      'Korea (South)': 'KR',
      'Kuwait': 'KW',
      'Kyrgyzstan': 'KG',
      'Laos': 'LA',
      'Latvia': 'LV',
      'Lebanon': 'LB',
      'Lesotho': 'LS',
      'Liberia': 'LR',
      'Libya': 'LY',
      'Liechtenstein': 'LI',
      'Lithuania': 'LT',
      'Luxembourg': 'LU',
      'Madagascar': 'MG',
      'Malawi': 'MW',
      'Malaysia': 'MY',
      'Maldives': 'MV',
      'Mali': 'ML',
      'Malta': 'MT',
      'Marshall Islands': 'MH',
      'Mauritania': 'MR',
      'Mauritius': 'MU',
      'Mexico': 'MX',
      'Micronesia': 'FM',
      'Moldova': 'MD',
      'Monaco': 'MC',
      'Mongolia': 'MN',
      'Montenegro': 'ME',
      'Morocco': 'MA',
      'Mozambique': 'MZ',
      'Myanmar': 'MM',
      'Namibia': 'NA',
      'Nauru': 'NR',
      'Nepal': 'NP',
      'Netherlands': 'NL',
      'New Zealand': 'NZ',
      'Nicaragua': 'NI',
      'Niger': 'NE',
      'Nigeria': 'NG',
      'North Macedonia': 'MK',
      'Norway': 'NO',
      'Oman': 'OM',
      'Pakistan': 'PK',
      'Palau': 'PW',
      'Palestine': 'PS',
      'Panama': 'PA',
      'Papua New Guinea': 'PG',
      'Paraguay': 'PY',
      'Peru': 'PE',
      'Philippines': 'PH',
      'Poland': 'PL',
      'Portugal': 'PT',
      'Qatar': 'QA',
      'Romania': 'RO',
      'Russia': 'RU',
      'Rwanda': 'RW',
      'Saint Kitts and Nevis': 'KN',
      'Saint Lucia': 'LC',
      'Saint Vincent and the Grenadines': 'VC',
      'Samoa': 'WS',
      'San Marino': 'SM',
      'Sao Tome and Principe': 'ST',
      'Saudi Arabia': 'SA',
      'Senegal': 'SN',
      'Serbia': 'RS',
      'Seychelles': 'SC',
      'Sierra Leone': 'SL',
      'Singapore': 'SG',
      'Slovakia': 'SK',
      'Slovenia': 'SI',
      'Solomon Islands': 'SB',
      'Somalia': 'SO',
      'South Africa': 'ZA',
      'South Sudan': 'SS',
      'Spain': 'ES',
      'Sri Lanka': 'LK',
      'Sudan': 'SD',
      'Suriname': 'SR',
      'Sweden': 'SE',
      'Switzerland': 'CH',
      'Syria': 'SY',
      'Tajikistan': 'TJ',
      'Tanzania': 'TZ',
      'Thailand': 'TH',
      'Timor-Leste': 'TL',
      'Togo': 'TG',
      'Tonga': 'TO',
      'Trinidad and Tobago': 'TT',
      'Tunisia': 'TN',
      'Turkey': 'TR',
      'Turkmenistan': 'TM',
      'Tuvalu': 'TV',
      'Uganda': 'UG',
      'Ukraine': 'UA',
      'United Arab Emirates': 'AE',
      'United Kingdom': 'GB',
      'United States': 'US',
      'Uruguay': 'UY',
      'Uzbekistan': 'UZ',
      'Vanuatu': 'VU',
      'Vatican City': 'VA',
      'Venezuela': 'VE',
      'Vietnam': 'VN',
      'Yemen': 'YE',
      'Zambia': 'ZM',
      'Zimbabwe': 'ZW',
    };

    String? countryCode = countryCodes[countryName];

    if (countryCode == null) {
      return '🏳️';
    }

    String emoji = countryCode
        .toUpperCase()
        .codeUnits
        .map((code) => String.fromCharCode(0x1F1E6 + code - 65))
        .join();

    return emoji;
  }
}
