import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import '../../../core/network_caller/service/service.dart';
import '../../../core/network_caller/utils/utils.dart';

class LoginController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  TextEditingController emailText = TextEditingController();
  TextEditingController passText = TextEditingController();

  RxBool isLoading = false.obs;

  Future<void> logIn() async {
    preferencesHelper.init();
    Map<String, dynamic> registration = {
      "email": emailText.text.trim(),
      "password": passText.text.trim(),
      "fcpmToken": preferencesHelper.getString("fcm_token")
    };

    try {
      await preferencesHelper.init();
      isLoading.value = true;
      debugPrint("=====${preferencesHelper.getString("fcm_token")}");

      String url = Utils.baseUrl + Utils.login;

      final response = await NetworkCaller().postRequest(
        url,
        body: registration,
      );
      if (response.isSuccess) {
        preferencesHelper.setString(
            "userToken", response.responseData['accessToken']);
        preferencesHelper.setString("userId", response.responseData['id']);
        var accountSetup = response.responseData["accountSetup"];
        if(accountSetup == false){
        Get.offAllNamed(AppRoute.selectCountry);
        }else{
          Get.offAllNamed(AppRoute.meet);
        }
        
        Get.snackbar(
          "Succes",
          "Login Succesfull",
        );
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
