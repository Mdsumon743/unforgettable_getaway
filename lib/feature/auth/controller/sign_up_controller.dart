import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/network_caller/service/service.dart';
import 'package:unforgettable_getaway/core/network_caller/utils/utils.dart';

class SignUpController extends GetxController {
  final emailText = TextEditingController();
  final passText = TextEditingController();
  final confirmPaassText = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> signUp() async {
    Map<String, dynamic> registration = {
      "email": emailText.text,
      "password": passText.text,
    };

    try {
      isLoading.value = true;

      String url = Utils.baseUrl + Utils.user;

      await NetworkCaller().postRequest(
        url,
        body: registration,
      );
    } catch (e) {
      debugPrint("Error: $e");
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  String? validatePasswordMatch(String? value) {
    if (value != passText.value.text) return "Passwords do not match";
    return null;
  }
}
