import 'package:get/get.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/screen/city_selection_screen.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/forget_password.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/login.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/login_or_signup_screen.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/sign_up_screen.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/screen/meet_people.dart';
import 'package:unforgettable_getaway/feature/onboarding/presentation/screen/onboarding.dart';

class AppRoute {
  static const String onboarding = '/onboarding';
  static const String loginSignUppage = '/loginSignUpPage';
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String forgetPpassword = '/forgotPassword';
  static const String meet = '/meet';
  static const String selectCountry = "/selectCountry";
  static final route = [
    GetPage(
        name: meet,
        page: () => const MeetPeople(),
        transition: Transition.rightToLeft),
         GetPage(
        name: selectCountry,
        page: () => const CitySelectionScreen(),
        transition: Transition.rightToLeft),
          GetPage(
        name: forgetPpassword,
        page: () => const ForgetScreen(),
        transition: Transition.rightToLeft),
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
