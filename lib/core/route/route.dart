import 'package:get/get.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/login.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/login_or_signup_screen.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/sign_up_screen.dart';
import 'package:unforgettable_getaway/feature/onboarding/presentation/screen/onboarding.dart';

class AppRoute {
  static const String onboarding = '/onboarding';
  static const String loginSignUppage = '/loginSignUpPage';
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static final route = [
    GetPage(
        name: onboarding,
        page: () => const Onboarding(),
        transition: Transition.rightToLeft),
    GetPage(
        name: loginSignUppage,
        page: () => const LoginOrSignupScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: loginScreen,
        page: () => const LoginScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: signUpScreen,
        page: () => const SignUpScreen(),
        transition: Transition.rightToLeft),
  ];
}
