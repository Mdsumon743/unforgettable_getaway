import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/network_caller/service/service.dart';
import 'package:unforgettable_getaway/feature/meet_people/model/all_profile.dart';

import '../../../core/helper/shared_prefarences_helper.dart';
import '../../../core/network_caller/utils/utils.dart';

class AllProfileController extends GetxController {
  RxBool isLoading = false.obs;
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

  RxList<ProfileResponse> allProfiles = <ProfileResponse>[].obs;

  Future<void> getUserProfiles() async {
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");
    debugPrint("Token: $token");

    if (token != null) {
      isLoading.value = true;
      try {
        final response = await NetworkCaller()
            .getRequest(Utils.baseUrl + Utils.profile, token: token);
        debugPrint("Response Status: ${response.isSuccess}");
        debugPrint("Response Body: ${response.responseData}");

        if (response.isSuccess) {
          final jsonData = response.responseData;

          if (jsonData is Map<String, dynamic>) {
            if (jsonData['success'] == true && jsonData['data'] is List) {
              List<dynamic> dataList = jsonData['data'];
              allProfiles.value = dataList
                  .map((profileData) => ProfileResponse.fromJson(profileData))
                  .toList();
              debugPrint("Profiles retrieved: ${allProfiles.length}");
              debugPrint("===========: ${allProfiles.length}");
            } else {
              debugPrint("Invalid response data structure");
            }
          } else if (jsonData is List) {
            allProfiles.value = jsonData
                .map((profileData) => ProfileResponse.fromJson(profileData))
                .toList();
            debugPrint("Profiles retrieved: ${allProfiles.length}");
            debugPrint("Profiles =========: $allProfiles");
          } else {
            debugPrint("Unexpected response format");
          }
        } else {
          debugPrint("Failed to retrieve data: ${response.responseData}");
        }
      } catch (e) {
        debugPrint("Error occurred: $e");
      } finally {
        isLoading.value = false;
      }
    } else {
      debugPrint("Token is null");
    }
  }

  @override
  void onInit() {
    super.onInit();
    getUserProfiles();
  }
}
