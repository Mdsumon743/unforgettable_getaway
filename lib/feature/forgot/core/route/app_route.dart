import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:unforgettable_getaway/feature/forgot/widget/screen/otp_screen.dart';

class AppRouts {
  static const String otpScreen = "/otpScreen";

  static List<GetPage> routes = [
    GetPage(name: otpScreen, page: () => OtpScreen()),
  ];
}