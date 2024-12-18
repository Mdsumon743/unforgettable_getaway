import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_textfield.dart';
import 'package:unforgettable_getaway/core/helper/form_validation.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/screen/name_birthday.dart';
import 'package:unforgettable_getaway/feature/auth/controller/forgot_password_controller.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newFormKey = GlobalKey<FormState>();
    final ForgotPasswordController forgotPasswordController =
        Get.put(ForgotPasswordController());
    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      body: SingleChildScrollView(
        // primary: true,

        child: Form(
          key: newFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo_image.png'),
                  ],
                ),
                SizedBox(height: 40.h),
                Text(
                  "Create New Password",
                  style:
                      textStyle(24.sp, AppColors.whiteColor, FontWeight.w600),
                ),
                SizedBox(height: 40.h),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: textStyle(
                        16.sp,
                        AppColors.whiteColor.withOpacity(0.9),
                        FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      controller: forgotPasswordController.newPassword,
                      hintText: '***********',
                      validator: FormValidation.validatePassword,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Confirm Password',
                      style: textStyle(
                        16.sp,
                        AppColors.whiteColor.withOpacity(0.9),
                        FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      controller: forgotPasswordController.newConfirmPass,
                      hintText: '***********',
                      validator: forgotPasswordController.validatePasswordMatch,
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(height: 26.h),
                    CustomButton(
                      text: "Save",
                      textColor: const Color(0XFF0D0D0C),
                      backgroundColor: const Color(0XFFFFDF00),
                      borderRadius: 40,
                      onPressed: () {
                       
                      },
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
