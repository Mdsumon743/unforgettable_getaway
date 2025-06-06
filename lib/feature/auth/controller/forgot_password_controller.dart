import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/network_caller/service/service.dart';
import 'package:unforgettable_getaway/core/network_caller/utils/utils.dart';
import 'package:unforgettable_getaway/core/route/route.dart';

import '../../../core/global_widget/custom_dialog.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController forgotText = TextEditingController();
  TextEditingController pinput = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newConfirmPass = TextEditingController();
  RxBool isLoading = false.obs;

  String? validatePasswordMatch(String? value) {
    if (value != newPassword.value.text) return "Passwords do not match";
    return null;
  }

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

  Future<void> setNewPassword() async {
    Map<String, dynamic> emailPass = {
      "email": forgotText.text,
      "password": newConfirmPass.text
    };

    try {
      isLoading.value = true;
      final response = await NetworkCaller()
          .postRequest(Utils.baseUrl + Utils.reset, body: emailPass);

      if (response.isSuccess) {
        if (response.isSuccess) {
          Get.dialog(
            CustomSuccessDialog(
              title: 'Password Reset Succesful',
              message:
                  'You are successfully reset your password.\nPlease log in to your account.',
              onConfirm: () {
                Get.back();
                Get.offAllNamed(AppRoute.loginScreen);
              },
            ),
            barrierDismissible: false,
            transitionCurve: Curves.easeOutBack,
            transitionDuration: const Duration(milliseconds: 400),
          );
        }

        Get.offAllNamed(AppRoute.loginScreen);
      }
    } catch (e) {
      debugPrint("======$e");
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
