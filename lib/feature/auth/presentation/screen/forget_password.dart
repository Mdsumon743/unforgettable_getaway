import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_textfield.dart';
import 'package:unforgettable_getaway/core/helper/form_validation.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
import 'package:unforgettable_getaway/feature/auth/controller/forgot_password_controller.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forgotFormKey = GlobalKey<FormState>();
    final forgotController = Get.put(ForgotPasswordController());
    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      body: Form(
        key: forgotFormKey,
        child: SingleChildScrollView(
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
                Column(
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
                      controller: forgotController.forgotText,
                      hintText: 'Example@email.com',
                      validator: FormValidation.validateEmail,
                    ),
                    SizedBox(height: 30.h),
                    Obx(() => forgotController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          )
                        : CustomButton(
                            text: "Get Verification Code",
                            textColor: const Color(0XFF0D0D0C),
                            backgroundColor: const Color(0XFFFFDF00),
                            borderRadius: 40,
                            onPressed: () {
                              if (forgotFormKey.currentState!.validate()) {
                                forgotController.forgotPassword();
                              }
                            },
                          )),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
