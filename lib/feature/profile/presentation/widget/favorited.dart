import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/screen/favorites_list.dart';

Widget fovoritedMe(
  String count,
  String text,
) {
  return GestureDetector(
    onTap: () {
      Get.to(() => const FavoritesList());
    },
    child: Column(
      children: [
        CustomTextPopins(
          text: count,
          fontWeight: FontWeight.w600,
          size: 24.sp,
          color: Colors.white,
        ),
        SizedBox(
          height: 5.h,
        ),
        CustomTextPopins(
          text: text,
          fontWeight: FontWeight.w400,
          size: 16.sp,
          color: Colors.white.withOpacity(0.85),
        ),
      ],
    ),
  );
}
