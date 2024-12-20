
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationController extends GetxController {
  var country = "Unknown".obs;
  var city = "Unknown".obs;
  var isLoading = false.obs;

  /// Check if location services are enabled, prompt if not
  Future<bool> checkLocationServices() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.defaultDialog(
        title: "Location Services Disabled",
        middleText: "Please enable location services to use this feature.",
        confirm: ElevatedButton(
          onPressed: () async {
            // Open device settings to enable location services
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

  /// Get user's current location (latitude and longitude)
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await checkLocationServices();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied. We cannot request permissions.');
    }

    // Get the current position
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  /// Get address from latitude and longitude
  Future<void> getAddressFromCoordinates() async {
    try {
      isLoading.value = true;

      // Get current location
      Position position = await getCurrentLocation();

      // Perform reverse geocoding
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        country.value = place.country ?? "Unknown";
        city.value = place.locality ?? "Unknown";
      } else {
        throw Exception('No address found.');
      }
    } catch (e) {
      debugPrint('Error fetching location: $e');
    } finally {
      debugPrint("========$city");
      debugPrint("========$country");
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
   
    super.onInit();
    getCurrentLocation();
    getAddressFromCoordinates();
    
  }
}
