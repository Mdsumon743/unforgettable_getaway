import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLogin extends GetxController {
  Future<void> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      var user = await googleSignIn.signIn();
      if (user != null) {
        debugPrint('======${user.displayName}');
        debugPrint('======${user.email}');
        debugPrint('======${user.photoUrl}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
