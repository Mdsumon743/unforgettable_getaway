import 'package:get/get.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/screen/city_selection_screen.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/screen/country_selection_screen.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/screen/gender_selection_screen.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/screen/height_selection_screen.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/screen/interest_selection_screen.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/screen/name_birthday.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/create_password.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/forget_password.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/login.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/login_or_signup_screen.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/sign_up_screen.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/verify_email_screen.dart';
import 'package:unforgettable_getaway/feature/home/presentation/screen/home.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/screen/meet_people.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/screen/profile_details.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/screen/search_location.dart';
import 'package:unforgettable_getaway/feature/message/presentation/screen/chat/empty_message.dart';
import 'package:unforgettable_getaway/feature/message/presentation/screen/chat/show_message_screen.dart';
import 'package:unforgettable_getaway/feature/notification/presentation/screen/empty_notification.dart';
import 'package:unforgettable_getaway/feature/notification/presentation/screen/notification.dart';
import 'package:unforgettable_getaway/feature/notification/presentation/screen/show_notification.dart';
import 'package:unforgettable_getaway/feature/onboarding/presentation/screen/onboarding.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/screen/profile.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/screen/profile_edit.dart';
import 'package:unforgettable_getaway/feature/tour_book/presentation/screen/tour.dart';

import '../../feature/account_setup/presentation/screen/profile_pic_upload.dart';

class AppRoute {
  static const String onboarding = '/onboarding';
  static const String loginSignUppage = '/loginSignUpPage';
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String forgetPpassword = '/forgotPassword';
  static const String meet = '/meet';
  static const String selectCountry = "/selectCountry";
  static const String verifyEmailScreen = "/verifyEmailScreen";
  static const String createPasword = "/createPassword";
  static const String selectCity = "/selectCiry";
  static const String namebirthScreen = "/namebirthScreen";
  static const String home = "/home";
  static const String tourpage = "/tourpage";
  static const String emtynotification = "/emtynotification";
  static const String notification = "/notification";
  static const String shownotification = "/shownotification";
  static const String searchLocaiton = "/searchLoacation";
  static const String gender = "/gender";
  static const String height = "/height";
  static const String profile = "/profile";
  static const String interestSelectionScreen = "/interestSelectionScreen";
  static const String profileDetils = "/profileDetils";
  static const String profileEdit = "/profileEdit";
  static const String emptyMessage = "/emptyMessage";
  static const String chatList = "/chatList";
  static const String uploadProfile = "/uploadProfile";

  static final route = [
    GetPage(
      name: chatList,
      page: () => const ShowMessageScreen(),
      transition: 
      Transition.rightToLeft,
    ),
    GetPage(
      name: uploadProfile,
      page: () => const ProfilePicUpload(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
        name: emptyMessage,
        page: () => const EmptyMessage(),
        transition: Transition.rightToLeft),
    GetPage(
        name: profileEdit,
        page: () => const ProfileEdit(),
        transition: Transition.rightToLeft),
    GetPage(
        name: profileDetils,
        page: () => const ProfileDetails(),
        transition: Transition.rightToLeft),
    GetPage(
        name: profile,
        page: () => const Profile(),
        transition: Transition.rightToLeft),
    GetPage(
        name: height,
        page: () => const HeightPickerScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: gender,
        page: () => const GenderSelectionScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: searchLocaiton,
        page: () => const SearchLocation(),
        transition: Transition.rightToLeft),
    GetPage(
        name: shownotification,
        page: () => const ShowNotification(),
        transition: Transition.rightToLeft),
    GetPage(
        name: emtynotification,
        page: () => const NotificationPage(),
        transition: Transition.rightToLeft),
    GetPage(
        name: emtynotification,
        page: () => const EmptyNotificationPage(),
        transition: Transition.rightToLeft),
    GetPage(
        name: tourpage,
        page: () => const TourPage(),
        transition: Transition.rightToLeft),
    GetPage(
        name: home,
        page: () => const Home(),
        transition: Transition.rightToLeft),
    GetPage(
        name: namebirthScreen,
        page: () => const NameBirthdayScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: selectCity,
        page: () => const CitySelectionScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: createPasword,
        page: () => const CreatePasswordScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: verifyEmailScreen,
        page: () => const VerifyEmailScreen(),
        transition: Transition.rightToLeft),
    GetPage(
        name: meet,
        page: () => const MeetPeople(),
        transition: Transition.rightToLeft),
    GetPage(
        name: selectCountry,
        page: () => const CountrySelectionScreen(),
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
    GetPage(
        name: interestSelectionScreen,
        page: () => const InterestSelectionScreen(),
        transition: Transition.rightToLeft),
  ];
}
