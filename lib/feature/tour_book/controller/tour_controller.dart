import 'package:get/get.dart';

class WebViewController extends GetxController {
  final isLoading = true.obs;
  late WebViewController webViewController;

  void onPageStarted(String url) {
    isLoading.value = true;
  }

  void onPageFinished(String url) {
    isLoading.value = false;
  }
}