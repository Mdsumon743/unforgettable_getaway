import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

import '../../../../core/global_widget/custom_text_popins.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A1110),
      appBar: AppBar(
        backgroundColor: const Color(0xff1A1110),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: CustomTextPopins(
          text: "Subscribe Plans",
          size: 20.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            CustomTextPopins(
              text: "Choose payment method",
              size: 24.h,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                SizedBox(width: 1.5.h),
                CustomTextPopins(
                  text: "We use secure transmission",
                  size: 14.h,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ],
            ),

            SizedBox(height: 9.h,),
            Row(
              children: [
                const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                SizedBox(width: 1.5.h),
                CustomTextPopins(
                  text: "We protect your personal information",
                  size: 14.h,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),

              ],
            ),
            SizedBox(height: 24.h,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(4.r), // Rounded corners
                border: Border.all(
                color:Colors.white.withOpacity(0.6),
                  width: 1, // Border width
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Subtle shadow color
                    blurRadius: 6, // Blur intensity
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
