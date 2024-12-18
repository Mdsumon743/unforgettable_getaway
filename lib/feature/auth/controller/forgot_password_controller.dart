import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/network_caller/service/service.dart';
import 'package:unforgettable_getaway/core/network_caller/utils/utils.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController forgotText = TextEditingController();

  Future<void> forgotPassword() async {
    Map<String, dynamic> email = {"email": forgotText.text};

    try {
      final response = await NetworkCaller()
          .postRequest(Utils.baseUrl + Utils.forgotpassword, body: email);

          if(response.isSuccess){
            
          }

    } catch (e) {
      debugPrint("======$e");
    }
  }
}
