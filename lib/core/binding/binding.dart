import 'package:get/get.dart';
import 'package:unforgettable_getaway/feature/auth/controller/login_controller.dart';
import 'package:unforgettable_getaway/feature/meet_people/controller/all_profile_controller.dart';
import 'package:unforgettable_getaway/feature/onboarding/controller/onboarding_controller.dart';

class AppBingding extends Bindings{
  @override
  void dependencies() {
   Get.put(()=> OnboardingController());
   Get.put(()=> LoginController());
   Get.put(()=> AllProfileController() ) ;
  }

}