import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

class Paymentcontroller extends GetxController {
  var selectedPayment = "".obs;
  var image = Assetpath.visa.obs;

  void selectPlan(String plan) {
    selectedPayment.value = plan;
    debugPrint("==============$selectedPayment");
    if (selectedPayment.value == 'credit_card') {
      image.value = Assetpath.creditcard;
    } else if (selectedPayment.value == 'visa_card') {
      image.value = Assetpath.visa;
    } else if (selectedPayment.value == 'apple_pay') {
      image.value = Assetpath.pay;
    } else if (selectedPayment.value == 'paypal') {
      image.value = Assetpath.paypal;
    } else if (selectedPayment.value == 'google_pay') {
      image.value = Assetpath.gpay;
    }
  }
}
