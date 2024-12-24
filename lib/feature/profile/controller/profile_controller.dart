import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
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

  Future<void> logout() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await preferencesHelper.init();

    var token = preferencesHelper.getString("userToken");
    debugPrint("Token: $token");

    if (token != null) {
      try {
        final response = await http.post(
          Uri.parse(Utils.baseUrl + Utils.logout),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token'
          },
        );
        debugPrint("Response Status: ${response.statusCode}");
        if (response.statusCode == 200) {
          preferencesHelper.clear();
          await googleSignIn.signOut();
          Get.offAllNamed(AppRoute.loginScreen);
        }
      } catch (e) {
        debugPrint("Error occurred: $e");
      }
    } else {
      debugPrint("Token is null");
    }
  }
}
