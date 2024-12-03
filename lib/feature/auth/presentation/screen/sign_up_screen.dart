import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_textfield.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/login.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 40.h),
              Image.asset('assets/images/logo_image_2.png'),
              SizedBox(height: 25.h),
              Text(
                "Sign up",
                style: textStyle(
                  24.sp,
                  const Color(0xFF0D0D0C),
                  FontWeight.w600,
                ),
              ),
               SizedBox(height: 25.h),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'E-mail',
                    style: textStyle(
                      16.sp,
                      AppColors.darkBrown1,
                      FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const CustomTextField(
                    hintText: 'Enter your mail address',
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Password',
                    style: textStyle(
                      16.sp,
                      AppColors.darkBrown1,
                      FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const CustomTextField(
                    hintText: '*********',
                    obscureText: true,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Confirm Password',
                    style: textStyle(
                      16.sp,
                      AppColors.darkBrown1,
                      FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  const CustomTextField(
                    hintText: '*********',
                    obscureText: true,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "ForgotPassword?",
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          decoration: TextDecoration.underline,
                          color: const Color(0xFF8C7B00),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    text: "Sign Up",
                    textColor: const Color(0XFF0D0D0C),
                    onPressed: () {},
                    backgroundColor: const Color(0XFFFFDF00),
                    borderRadius: 40,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(height: 16.h),
                  Center(
                    child: Text(
                      "Or Sign up with",
                      style: textStyle(
                          14.sp, const Color(0xFF333329), FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Center the icons horizontally
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(18.sp),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.sp, color: const Color(0xFF737268)),
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage('assets/images/google.png'),
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(18.sp),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.sp, color: const Color(0xFF737268)),
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/Facebook.png',
                              ),
                              // fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: textStyle(
                    14.sp,
                    const Color(0xFFFFFCE5).withOpacity(0.85),
                    FontWeight.w400,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Already have an account?",
                      style: textStyle(
                        14.sp,
                        const Color(0xFF333329).withOpacity(0.85),
                        FontWeight.w400,
                      ),
                    ),
                    TextSpan(
                      text: ' Log In',
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF8C7B00),
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.to(() => const LoginScreen());
                        },
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
