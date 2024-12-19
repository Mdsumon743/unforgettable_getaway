import 'dart:async';

import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';
import 'package:unforgettable_getaway/core/route/route.dart';

class OnboardingController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

  @override
  void onInit() {
    super.onInit();
    Timer(
      const Duration(seconds: 3),
      () {
        chekUseravalible();
      },
    );
  }

  Future<void> chekUseravalible() async {
    await preferencesHelper.init();
    final String? userToken = preferencesHelper.getString("userToken");
    if (userToken != null) {
      Get.offAllNamed(AppRoute.selectCountry);
    } else {
      Get.offAllNamed(AppRoute.loginSignUppage);
    }
  }
}
