import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helper/shared_prefarences_helper.dart';

class CustomTextFieldSearchController extends GetxController {
  TextEditingController search = TextEditingController();
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  RxBool isAccount = true.obs;
  RxList<String> citiesAndCountries = RxList([
    "New York, USA",
    "London, UK",
    "Paris, France",
    "Tokyo, Japan",
    "Sydney, Australia",
    "Berlin, Germany",
    "Moscow, Russia",
    "Toronto, Canada",
    "São Paulo, Brazil",
    "Delhi, India",
    "Shanghai, China",
    "Seoul, South Korea",
    "Mexico City, Mexico",
    "Rome, Italy",
    "Cairo, Egypt"
  ]);

  saveValue() async {
    await preferencesHelper.init();
    preferencesHelper.setBool("FirstTime", isAccount.value);
  }

  @override
  void onInit() {
    super.onInit();
    saveValue();
  }

  RxList<String> filteredSuggestions = RxList([]);

  void filterSuggestions(String query) {
    if (query.isEmpty) {
      filteredSuggestions.value = [];
    } else {
      filteredSuggestions.value = citiesAndCountries
          .where((cityCountry) =>
              cityCountry.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void updateTextController(TextEditingController? controller, String value) {
    controller?.text = value;
  }

  @override
  void onClose() {
    super.onClose();

    search.dispose();
  }
}
