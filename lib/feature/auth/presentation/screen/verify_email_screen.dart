import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/helper/form_validation.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
import 'package:unforgettable_getaway/feature/auth/controller/forgot_password_controller.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final _loginFormKey = GlobalKey<FormState>();
    // const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    // const fillColor = Color.fromRGBO(243, 246, 249, 0);
    // const borderColor = Color.fromRGBO(23, 171, 144, 0.4);
    final forgotPasswordController = Get.put(ForgotPasswordController());
    final pinFormKey = GlobalKey<FormState>();

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
      body: SingleChildScrollView(
        // primary: true,

        child: Form(
          key: pinFormKey,
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
                  // key: _loginFormKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'A verification code send in your gmail',
                        style: textStyle(
                          14.sp,
                          AppColors.whiteColor.withOpacity(0.9),
                          FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Pinput(
                        length: 6,
                        controller: forgotPasswordController.pinput,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme,
                        submittedPinTheme: defaultPinTheme,
                        validator: FormValidation.validatePin,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) => debugPrint(pin),
                      ),
                      SizedBox(height: 40.h),
                      Obx(() => forgotPasswordController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.amber,
                              ),
                            )
                          : CustomButton(
                              text: "Submit",
                              textColor: const Color(0XFF0D0D0C),
                              backgroundColor: const Color(0XFFFFDF00),
                              borderRadius: 40,
                              onPressed: () {
                                if (pinFormKey.currentState!.validate()) {
                                  forgotPasswordController.pinSubmit();
                                }
                              },
                            )),
                      SizedBox(height: 25.h),
                      Center(
                        child: Text(
                          "Resend Code",
                          style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.yellowColor,
                            color: AppColors.yellowColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
