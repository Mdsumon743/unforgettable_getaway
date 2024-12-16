
import 'package:get/get.dart';

class Paymentcontroller extends GetxController {
  var selectedPlan = "".obs;

  void selectPlan(String plan) {
    selectedPlan.value = plan;
  }
}

