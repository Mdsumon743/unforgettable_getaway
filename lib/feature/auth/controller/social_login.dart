import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:unforgettable_getaway/core/network_caller/service/service.dart';
import 'package:unforgettable_getaway/core/network_caller/utils/utils.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/feature/profile/controller/profile_controller.dart';
import '../../../core/helper/shared_prefarences_helper.dart';

class SocialLogin extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final profileController = Get.put(ProfileController());
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
          bool? accountSetup = response.responseData["accountSetup"] ?? false;
          profileController.getUserProfiles().then(
            (value) {
              if (accountSetup == false) {
                Get.offAllNamed(AppRoute.selectCountry);
              } else {
                Get.offAllNamed(AppRoute.meet);
              }
            },
          );

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

  Future<UserCredential> signInGoogleIos() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        debugPrint("Google Sign-In was canceled by the user.");
        return Future.error("Sign-In Canceled");
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        debugPrint("User Name: ${user.displayName}");
        debugPrint("User Email: ${user.email}");
        debugPrint("User UID: ${user.uid}");
      }

      return userCredential;
    } catch (error) {
      debugPrint("Error during Google Sign-In: $error");
      return Future.error(error);
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
