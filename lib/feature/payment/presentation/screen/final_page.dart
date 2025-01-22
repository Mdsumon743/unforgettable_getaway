import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

import '../../../../core/global_widget/custom_text_popins.dart';

class FinalPage extends StatelessWidget {
  const FinalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1A1110),
      appBar: AppBar(
        backgroundColor: const Color(0xff1A1110),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoute.meet);
              },
              icon: Image.asset(
                Assetpath.cross,
                height: 24.h,
                width: 24.w,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            Assetpath.finalpic,
            height: 360.h,
            width: 360.w,
          ),
          CustomTextPopins(
            text: "Payment Successful",
            size: 24.h,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
