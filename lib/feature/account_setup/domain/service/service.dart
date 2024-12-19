import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CitiesController extends GetxController {
  var cities = <String>[].obs;
  var isLoading = false.obs;

  Future<void> fetchCities(String country) async {
    final url = Uri.parse(
        'https://countriesnow.space/api/v0.1/countries/cities/q?country=$country');
    isLoading.value = true;

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['error'] == false) {
          cities.value = List<String>.from(data['data']);
        } else {
          Get.snackbar('Error', 'Failed to retrieve cities: ${data['msg']}');
          debugPrint("API Error: ${data['msg']}");
        }
      } else {
        Get.snackbar('Error', 'Server error: ${response.statusCode}');
        debugPrint("HTTP Status: ${response.statusCode}");
        debugPrint("Response Body: ${response.body}");
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
      debugPrint("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
