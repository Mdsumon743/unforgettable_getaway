import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:unforgettable_getaway/core/network_caller/service/service.dart';
import 'package:unforgettable_getaway/core/network_caller/utils/utils.dart';
import 'package:unforgettable_getaway/core/route/route.dart';

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
          "fcpmToken": preferencesHelper.getString("fcm_token")
        };

        final response = await NetworkCaller().postRequest(
            Utils.baseUrl + Utils.googleLogin,
            body: userCredintial);

        if (response.isSuccess) {
          await preferencesHelper.setString(
              "userToken", response.responseData['accessToken']);
          await preferencesHelper.setString(
              "userId", response.responseData['id']);
          var accountSetup = response.responseData["accountSetup"];
          if (accountSetup == false) {
            Get.offAllNamed(AppRoute.selectCountry);
          } else {
            Get.offAllNamed(AppRoute.meet);
          }
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

  String? userName;
  String? userEmail;
  String? userProfilePic;

  Future<void> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance
            .getUserData(fields: "name,email,picture.width(200)");

        userName = userData["name"];
        userEmail = userData["email"];
        userProfilePic = userData["picture"]["data"]["url"];

        debugPrint('Name: $userName');
        debugPrint('Email: $userEmail');
        debugPrint('Profile Picture: $userProfilePic');
      } else if (result.status == LoginStatus.cancelled) {
        debugPrint("Login cancelled by the user.");
      } else {
        debugPrint("Error: ${result.message}");
      }
    } catch (e) {
      debugPrint("Error during Facebook login: $e");
    }
  }
}
