import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';

class ResponsiveHelper {
  static bool isWeb() => kIsWeb;

  static bool isSmallDevice() {
    final size = MediaQuery.of(Get.context!).size.width;
    return size < 400;
  }

  static bool isMediumDevice() {
    final size = MediaQuery.of(Get.context!).size.width;
    return size >= 400 && size < 650;
  }

  static bool isLargeDevice() {
    final size = MediaQuery.of(Get.context!).size.width;
    return size >= 650 && size < 850;
  }

  static bool isTablet() {
    final size = MediaQuery.of(Get.context!).size.width;
    return size >= 850 && size < 1100;
  }

  static bool isDesktop() {
    final size = MediaQuery.of(Get.context!).size.width;
    return size >= 1100;
  }

  static bool isMobile() {
    return !isWeb() || isSmallDevice() || isMediumDevice() || isLargeDevice();
  }
}
