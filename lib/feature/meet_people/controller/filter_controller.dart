// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/const/const.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

import 'package:unforgettable_getaway/feature/meet_people/controller/all_profile_controller.dart';

class FilterController extends GetxController {
  var selectedCountry = Rxn<String>();

  void updateCountry(String country) {
    selectedCountry.value = country;
  }

  void showCountryPicker(BuildContext context) {
    final allprofileData = Get.find<AllProfileController>();

    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4.h,
              width: 86.w,
              decoration: BoxDecoration(
                  color: const Color(0xff333329),
                  borderRadius: BorderRadius.circular(25.r)),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextPopins(
              text: "Filter",
              color: Colors.black,
              fontWeight: FontWeight.w600,
              size: 24.sp,
            ),
            SizedBox(height: 20.r),
            Obx(() {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextPopins(
                      text: "Select Country",
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      size: 18.sp,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedCountry.value,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          updateCountry(newValue);
                          String filteredCountry = newValue.characters
                              .where((char) => RegExp(
                                      r'[\u0020-\u007E\u00A0-\u00FF\u0100-\u017F\u0180-\u024F]')
                                  .hasMatch(char))
                              .join();
                          allprofileData.searchQuery = filteredCountry;
                          allprofileData.text.value =
                              "People around '${allprofileData.searchQuery}'";
                          debugPrint(
                              "Selected Country: =======>>>${allprofileData.searchQuery}");
                        }
                      },
                      items: Const.countries
                          .map<DropdownMenuItem<String>>((String country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                      isExpanded: true,
                      iconSize: 30,
                      icon: const Icon(Icons.arrow_drop_down),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      dropdownColor: Colors.grey[200],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.amber.withOpacity(.02),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xff737268))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                const BorderSide(color: Color(0xff737268))),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        checkLocationPermissionAndGetCountry(allprofileData);
                      },
                      child: Row(
                        children: [
                          Image.asset(Assetpath.near),
                          SizedBox(
                            width: 5.w,
                          ),
                          CustomTextPopins(
                            text: "Use my current location",
                            color: const Color(0xff8C7B00),
                            size: 16.sp,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    allprofileData.getUserCity();
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                      color: const Color(0xffFFDF00),
                      borderRadius: BorderRadius.circular(48.r),
                    ),
                    child: Center(
                      child: CustomTextPopins(
                        text: "Apply Filters",
                        fontWeight: FontWeight.w500,
                        size: 16.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.all(15.r),
                    decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(48.r),
                        border: Border.all(color: const Color(0xff8C7B00))),
                    child: Center(
                      child: CustomTextPopins(
                        text: "Reset Filters",
                        fontWeight: FontWeight.w500,
                        size: 16.sp,
                        color: const Color(0xff8C7B00),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkLocationPermissionAndGetCountry(
      AllProfileController allProfileController) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        debugPrint("Location permission denied.");
        return;
      }
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("Location services are not enabled.");
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String country =
        placemarks.isNotEmpty ? placemarks[0].country ?? "Unknown" : "Unknown";

    debugPrint("Country: $country");

    String storedCountry = country;

    allProfileController.searchQuery = storedCountry.trim();
    debugPrint("Stored Country:==========>>>>>> $storedCountry");
    debugPrint(
        "Controller Country:==========>>>>>> ${allProfileController.searchQuery}");
  }
}
