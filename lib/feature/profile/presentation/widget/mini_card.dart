import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';

import '../../../../core/utils/assetpath.dart';

class MiniCard extends StatelessWidget {
  final String text;
  final String dollar;
  const MiniCard({super.key, required this.text, required this.dollar});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.r, horizontal: 10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.white.withOpacity(0.8), width: 1)),
      child: Row(
        children: [
          Image.asset(
            Assetpath.blink2,
            height: 32.h,
            width: 32.w,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            children: [
              CustomTextPopins(
                text: text,
                fontWeight: FontWeight.w500,
                size: 14.sp,
                color: Colors.white.withOpacity(0.85),
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomTextPopins(
                text: dollar,
                fontWeight: FontWeight.w600,
                size: 24.sp,
                color: Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }
}
