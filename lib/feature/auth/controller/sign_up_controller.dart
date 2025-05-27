import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/network_caller/service/service.dart';
import 'package:unforgettable_getaway/core/network_caller/utils/utils.dart';
import 'package:unforgettable_getaway/feature/auth/controller/login_controller.dart';

import '../../../core/global_widget/custom_dialog.dart';

class SignUpController extends GetxController {
  final logincontroller = Get.put(LoginController());
  final emailText = TextEditingController();
  final passText = TextEditingController();
  final confirmPaassText = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> signUp() async {
    Map<String, dynamic> registration = {
      "email": emailText.text.trim(),
      "password": passText.text.trim(),
    };

    try {
      isLoading.value = true;

      String url = Utils.baseUrl + Utils.user;

      final response = await NetworkCaller().postRequest(
        url,
        body: registration,
      );

      if (response.isSuccess) {
        logincontroller.logIn(
            email: emailText.text.trim(), password: passText.text.trim());
        Get.dialog(
          CustomSuccessDialog(
            title: 'Sign Up Successful!',
            message:
                'You are successfully signed up.\nPlease log in to your account.',
            onConfirm: () {
              logincontroller.logIn(
                  email: emailText.text.trim(), password: passText.text.trim());
            },
          ),
          barrierDismissible: false,
          transitionCurve: Curves.easeOutBack,
          transitionDuration: const Duration(milliseconds: 400),
        );
      
      } else if (response.statusCode == 400) {
        Get.snackbar(
          "Error",
          "This email is already registered.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String? validatePasswordMatch(String? value) {
    if (value != passText.value.text) return "Passwords do not match";
    return null;
  }
}
