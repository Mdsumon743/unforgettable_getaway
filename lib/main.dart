import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:unforgettable_getaway/app.dart';
import 'package:unforgettable_getaway/core/binding/binding.dart';
import 'package:unforgettable_getaway/feature/onboarding/controller/onboarding_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppBingding().dependencies();
  OnboardingController().onInit();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}
