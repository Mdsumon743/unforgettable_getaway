import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';

class LoginOrSignupScreen extends StatelessWidget {
  const LoginOrSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/images/logo_image.png'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: "Log in",
                  textColor: const Color(0XFF0D0D0C),
                      backgroundColor: const Color(0XFFFFDF00),
                      borderRadius: 40,
                  onPressed: () {
                    Get.toNamed(AppRoute.loginScreen);
                  },
                 
                ),
                SizedBox(height: 10.h),
                CustomButton(
                  text: "Sign Up",
                  textColor: const Color(0XFF0D0D0C),
                  backgroundColor: const Color(0XFFFFDF00),
                  borderRadius: 40,
                  onPressed: () {
                      Get.toNamed(AppRoute.signUpScreen);
                  },
                ),
                SizedBox(height: 40.h),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: textStyle(
                      14.sp,
                      const Color(0xFFFFFCE5),
                      FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'By tapping “sign in”, you agree to our ',
                      ),
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: GoogleFonts.poppins(
                          // color: const Color(0xFFFFFCE5).withOpacity(0.85),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            debugPrint('Navigate to Terms & Conditions');
                          },
                      ),
                      const TextSpan(
                        text: '. See how we use your data in our ',
                      ),
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: GoogleFonts.poppins(
                          // color: const Color(0xFFFFFCE5).withOpacity(0.85),
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                        
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
