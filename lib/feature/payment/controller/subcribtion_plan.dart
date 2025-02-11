import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';
import 'package:unforgettable_getaway/feature/payment/model/plan.dart';
import 'package:unforgettable_getaway/feature/payment/presentation/screen/final_page.dart';

import '../../../core/network_caller/service/service.dart';
import '../../../core/network_caller/utils/utils.dart';

class SubscriptionController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  var selectedPlan = "".obs;
  var subcribtionId = "".obs;
  var price = 0.0.obs;
  RxBool isLoading = false.obs;

  RxList<Plan> allPlan = <Plan>[].obs;


  void selectPlan(String plan, double value, String subId) {
    selectedPlan.value = plan;
    price.value = value;
    subcribtionId.value = subId;

    debugPrint("==============$price");
    debugPrint("==============$subcribtionId");
  }

  Future<void> getAllPlan() async {
    debugPrint("Get all plan===================");
     debugPrint("Get all plan=========$allPlan==========");

    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");
    debugPrint("Token: $token");

    if (token != null) {
      try {
        final response = await NetworkCaller()
            .getRequest(Utils.baseUrl + Utils.plan, token: token);
        debugPrint("Response Status: ${response.isSuccess}");
        debugPrint("Response Body: ${response.responseData}");

        if (response.isSuccess) {
          debugPrint("===================Data Get Successfully");
          final jsonData = response.responseData;
          if (jsonData is List) {
            allPlan.value = jsonData.map((e) => Plan.fromJson(e)).toList();
            debugPrint("==========Plans loaded successfully: ${allPlan.length}");
            debugPrint("============$allPlan");
          } else {
            debugPrint("Unexpected data format: $jsonData");
          }
        } else {
          debugPrint("Failed to retrieve data: ${response.responseData}");
        }
      } catch (e) {
        debugPrint("Error occurred: $e");
      } finally {
        debugPrint("Finally block executed===========$allPlan");
      }
    } else {
      debugPrint("Token is null");
    }
  }

  Future<void> sendPaymentServer(String paymentId) async {
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");
    debugPrint("Token: $token");
    Map<String, dynamic> data = {
      "subscriptionPlanId": subcribtionId.value,
      "paymentMethodId": paymentId
    };
    if (token != null) {
      try {
        isLoading.value = true;
        final response = await NetworkCaller().postRequest(
            Utils.baseUrl + Utils.payment,
            token: token,
            body: data);
        debugPrint("${response.statusCode}");
        if (response.isSuccess) {
          debugPrint("==========>>>>${response.responseData}");
          Get.to(() => const FinalPage());
        }
      } catch (e) {
        isLoading.value = false;
        debugPrint("========$e");
      } finally {
        isLoading.value = false;
      }
    }
  }



}
