import 'dart:async';

import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/route/route.dart';

class OnboardingController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(
      const Duration(seconds: 3),
      () {
        Get.offAllNamed(AppRoute.loginSignUppage);
      },
    );
  }
}
