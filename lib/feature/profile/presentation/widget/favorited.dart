import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';

Widget fovoritedMe(
  String count,
  String text,
  void Function() ontap,
) {
  return GestureDetector(
    onTap: ontap,
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
