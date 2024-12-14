import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

class Verification extends StatelessWidget {
  const Verification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextPopins(
            text: "Verification",
            fontWeight: FontWeight.w600,
            size: 20.sp,
            color: Colors.white,
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextPopins(
            text: "When someone is verified, it means\nthey’re for real",
            fontWeight: FontWeight.w400,
            size: 14.sp,
            color: Colors.white,
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomTextPopins(
            text: "Verification by number",
            fontWeight: FontWeight.w600,
            size: 20.sp,
            color: Colors.white,
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextPopins(
            text: "We will use your phone number to verify \nyour account",
            fontWeight: FontWeight.w400,
            size: 14.sp,
            color: Colors.white,
          ),
          SizedBox(
            height: 10.h,
          ),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48.h)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assetpath.phone),
                  SizedBox(
                    width: 10.w,
                  ),
                  CustomTextPopins(
                    text: "Add Number",
                    fontWeight: FontWeight.w500,
                    size: 18.sp,
                    color: const Color(0xff8C7B00),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
