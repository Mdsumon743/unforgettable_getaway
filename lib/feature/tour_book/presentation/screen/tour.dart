import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/tour_controller.dart';

class Tourpage extends StatelessWidget {
  const Tourpage(
      {super.key,
      required String initialUrl,
      required javascriptMode,
      required void Function(String url) onPageStarted,
      required void Function(String url) onPageFinished});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WebViewController());

    return Scaffold(
      body: Stack(
        children: [
          Tourpage(
            initialUrl: "https://unforgettablegetaway.com/",
            javascriptMode: true,
            onPageStarted: controller.onPageStarted,
            onPageFinished: controller.onPageFinished,
          ),
          Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
