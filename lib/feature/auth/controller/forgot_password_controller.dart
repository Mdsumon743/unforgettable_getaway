import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/network_caller/service/service.dart';
import 'package:unforgettable_getaway/core/network_caller/utils/utils.dart';
import 'package:unforgettable_getaway/core/route/route.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController forgotText = TextEditingController();
  TextEditingController pinput = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> forgotPassword() async {
    Map<String, dynamic> email = {"email": forgotText.text};

    try {
      isLoading.value = true;
      final response = await NetworkCaller()
          .postRequest(Utils.baseUrl + Utils.forgotpassword, body: email);

      if (response.isSuccess) {
        Get.toNamed(AppRoute.verifyEmailScreen);
      }
    } catch (e) {
      debugPrint("======$e");
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pinSubmit() async {
    int? intPin;
    try {
      intPin = int.parse(pinput.text);
      debugPrint("=====$intPin");
    } catch (e) {
      debugPrint("=====$e");
    }

    Map<String, dynamic> emailOtp = {"email": forgotText.text, "otp": intPin};

    try {
      isLoading.value = true;
      final response = await NetworkCaller()
          .postRequest(Utils.baseUrl + Utils.pin, body: emailOtp);

      if (response.isSuccess) {
        Get.toNamed(AppRoute.createPasword);
      } else {
        Get.snackbar("Error", "Failed to verify the PIN. Please try again.");
      }
    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar("Error", "An error occurred while verifying the PIN.");
    } finally {
      isLoading.value = false;
    }
  }
}
