import 'dart:async';

import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/feature/profile/controller/profile_controller.dart';

class OnboardingController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final profileController = Get.put(ProfileController());

  @override
  void onInit() {
    super.onInit();
 profileController.getUserProfiles();

    Timer(
      const Duration(seconds: 3),
      () {
        chekUseravalible();
      },
    );
  }

  Future<void> chekUseravalible() async {
    await preferencesHelper.init();
    bool isAccoutSetup = preferencesHelper.getBool('FirstTime') ?? false;
    final String? userToken = preferencesHelper.getString("userToken");
    if (userToken != null && isAccoutSetup == true) {
     
      Get.offAllNamed(AppRoute.searchLocaiton);
    } else if (userToken != null && isAccoutSetup == false) {
      Get.offAllNamed(AppRoute.selectCountry);
    } else {
      Get.offAllNamed(AppRoute.loginSignUppage);
    }
  }
}
