import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:unforgettable_getaway/app.dart';
import 'package:unforgettable_getaway/core/binding/binding.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';
import 'package:unforgettable_getaway/feature/notification/controller/notification_controller.dart';
import 'package:unforgettable_getaway/feature/onboarding/controller/onboarding_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AppBingding().dependencies();
  OnboardingController().onInit();
  final NotificationController fcmController =
      Get.put(NotificationController());
  await SharedPreferencesHelper().init();
  fcmController.onInit();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}
