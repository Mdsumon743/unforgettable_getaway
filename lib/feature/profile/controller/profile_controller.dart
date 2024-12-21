import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/helper/shared_prefarences_helper.dart';
import '../../../core/network_caller/service/service.dart';
import '../../../core/network_caller/utils/utils.dart';
import '../model/profile_data.dart';

class ProfileController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

  Rx<UserData?> userData = Rx<UserData?>(null);

  Future<void> getUserProfiles() async {
    await preferencesHelper.init();

    var token = preferencesHelper.getString("userToken");
    debugPrint("Token: $token");

    if (token != null) {
      try {
        final response = await NetworkCaller()
            .getRequest(Utils.baseUrl + Utils.getme, token: token);
        debugPrint("Response Status: ${response.isSuccess}");
        debugPrint("Response Body: ${response.responseData}");
        if (response.isSuccess) {
          debugPrint("===========${response.responseData}");
          final Map<String, dynamic> jsonData =
              response.responseData is Map<String, dynamic>
                  ? response.responseData
                  : jsonDecode(response.responseData);

          userData.value = UserData.fromJson(jsonData);
          debugPrint("====HereData======${userData.value}");
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
