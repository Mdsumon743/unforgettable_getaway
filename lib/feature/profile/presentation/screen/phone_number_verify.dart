// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';

import '../../../../core/global_widget/custom_text_popins.dart';

class PhoneNumberOTPSubmit extends StatelessWidget {
  const PhoneNumberOTPSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    // final _loginFormKey = GlobalKey<FormState>();
    // const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    // const fillColor = Color.fromRGBO(243, 246, 249, 0);
    // const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 2.h),
      textStyle: textStyle(20.sp, AppColors.whiteColor, FontWeight.w500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: AppColors.whiteColor.withOpacity(0.05),
        border: Border.all(color: AppColors.whiteColor.withOpacity(0.2)),
      ),
    );
    return Scaffold(
        backgroundColor: AppColors.darkBrown,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: const Color(0xff1A1110),
          centerTitle: true,
          title: CustomTextPopins(
            text: "Account Verificaiton",
            fontWeight: FontWeight.w500,
            size: 20.sp,
            color: Colors.white,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextPopins(
                        textAlign: TextAlign.start,
                        text: "Verify Your Number",
                        fontWeight: FontWeight.w700,
                        size: 24.sp,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextPopins(
                        textAlign: TextAlign.start,
                        text:
                            "Enter the code we’ve sent by text to\n+123456789",
                        fontWeight: FontWeight.w400,
                        size: 14.sp,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'Code',
                        style: textStyle(
                          14.sp,
                          AppColors.whiteColor.withOpacity(0.9),
                          FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Pinput(
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme,
                        submittedPinTheme: defaultPinTheme,
                        validator: (s) {
                          return s == '2222' ? null : 'Pin is incorrect';
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) => debugPrint(pin),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                 
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 30.r),
                    child: CustomTextPopins(
                        fontWeight: FontWeight.w400,
                        size: 11.sp,
                        decoration: TextDecoration.underline,
                        color: const Color(0xffFFF6B2),
                        text:
                            "Resend code via SMS"),
                  ),
                ],
              ),
              FloatingActionButton(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r)),
                onPressed: () {
                  Get.to(() => const PhoneNumberOTPSubmit());
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xff8C7B00),
                ),
              ),
            ]));
  }
}
