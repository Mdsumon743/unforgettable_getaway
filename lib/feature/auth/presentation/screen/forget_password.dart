import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_textfield.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/verify_email_screen.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _loginFormKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      body: SingleChildScrollView(
        // primary: true,

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60.h),
              Image.asset('assets/images/logo_image.png'),
              SizedBox(height: 45.h),
              Form(
                key: _loginFormKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Your Email',
                      style: textStyle(
                        16.sp,
                        AppColors.whiteColor.withOpacity(0.9),
                        FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      hintText: 'Example@email.com',
                      validator: (value) {
                        return GetUtils.isEmail(value!)
                            ? null
                            : 'Enter YOur emasil Address';
                      },
                    ),
                    SizedBox(height: 30.h),
                    CustomButton(
                      text: "Get Verification Code",
                      textColor: const Color(0XFF0D0D0C),
                      backgroundColor: const Color(0XFFFFDF00),
                      borderRadius: 40,
                      onPressed: () {
                        // if (_loginFormKey.currentState!.validate()) {}
                        Get.to(const VerifyEmailScreen());
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
