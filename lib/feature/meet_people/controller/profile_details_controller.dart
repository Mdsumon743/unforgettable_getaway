import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:unforgettable_getaway/feature/meet_people/model/profile_details.dart';
import '../../../core/helper/shared_prefarences_helper.dart';
import '../../../core/network_caller/service/service.dart';
import '../../../core/network_caller/utils/utils.dart';

class ProfileDetailsController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  Rx<SingleProfileDetails?> profileDetailsData =
      Rx<SingleProfileDetails?>(null);

  Future<void> getSignleProfileDetails(String userID) async {
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");
    debugPrint("Token: $token");
    if (token != null) {
      try {
        final response = await NetworkCaller().getRequest(
            Utils.baseUrl + Utils.getsingleProfile + userID,
            token: token);
        debugPrint("Response Status: ${response.isSuccess}");
        debugPrint("Response Body: ${response.responseData}");
        if (response.isSuccess) {
          debugPrint("===========${response.responseData}");
          final Map<String, dynamic> jsonData =
              response.responseData is Map<String, dynamic>
                  ? response.responseData
                  : jsonDecode(response.responseData);
          profileDetailsData.value = SingleProfileDetails.fromJson(jsonData);
          debugPrint("====ProfileDetails======${profileDetailsData.value}");
        } else {
          debugPrint("Failed to retrieve data: ${response.responseData}");
        }
      } catch (e) {
        debugPrint("Error occurred: $e");
      }
    } else {
      debugPrint("Token is null");
    }
  }
}
