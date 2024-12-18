import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:unforgettable_getaway/core/network_caller/service/service.dart';
import 'package:unforgettable_getaway/core/network_caller/utils/utils.dart';

import '../../../core/helper/shared_prefarences_helper.dart';

class SocialLogin extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  Future<void> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      var user = await googleSignIn.signIn();
      if (user != null) {
        Map<String, dynamic> userCredintial = {
          "username": user.displayName.toString(),
          "email": user.email.toString(),
          "profileImage": user.photoUrl.toString(),
          "fcpmToken": "akn nai pore dimo"
        };

        final response = await NetworkCaller().postRequest(
            Utils.baseUrl + Utils.googleLogin,
            body: userCredintial);

        if (response.isSuccess) {
          preferencesHelper.setString(
              "userToken", response.responseData['accessToken']);
          preferencesHelper.setString("userId", response.responseData['id']);
          debugPrint("======login===Succes");
          debugPrint("======name===${user.displayName}");
          debugPrint("======email===${user.email}");
          debugPrint("======photo===${user.photoUrl}");
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
