import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CityController extends GetxController {
  RxString selectedCity = 'Select City'.obs;
  RxBool arrowDown = true.obs;

  void toggleMethod() {
    arrowDown.value = !arrowDown.value;
  }

  void selectCity(String city) {
    selectedCity.value = city;
    debugPrint("+++++++++++++${selectedCity.value}");
  }
}
