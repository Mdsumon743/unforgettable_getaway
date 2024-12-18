import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:unforgettable_getaway/app.dart';
import 'package:unforgettable_getaway/core/binding/binding.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';
import 'package:unforgettable_getaway/feature/onboarding/controller/onboarding_controller.dart';
import 'package:unforgettable_getaway/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppBingding().dependencies();
  OnboardingController().onInit();
  await SharedPreferencesHelper().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}
