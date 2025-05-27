// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_textfield.dart';
import 'package:unforgettable_getaway/core/global_widget/text_widget.dart';
import 'package:unforgettable_getaway/core/helper/form_validation.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
import 'package:unforgettable_getaway/feature/auth/controller/sign_up_controller.dart';
import 'package:unforgettable_getaway/feature/auth/controller/social_login.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signInFormKey = GlobalKey<FormState>();
    final SignUpController signUpController = Get.put(SignUpController());
    final SocialLogin socialLogin = Get.put(SocialLogin());

    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      body: Form(
        key: signInFormKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      )),
                ),
                Image.asset('assets/images/logo_image.png'),
                SizedBox(height: 25.h),
                const TextWidget(
                  text: 'Sign up',
                  fontSize: 24,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 25.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'E-mail',
                      fontSize: 16,
                      color: AppColors.whiteColor.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField2(
                      controller: signUpController.emailText,
                      hintText: 'Enter your mail address',
                      validator: FormValidation.validateEmail,
                    ),
                    SizedBox(height: 16.h),
                    TextWidget(
                      text: 'Password',
                      fontSize: 16,
                      color: AppColors.whiteColor.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField2(
                      controller: signUpController.passText,
                      max: 1,
                      hintText: '*********',
                      obscureText: true,
                      validator: FormValidation.validatePassword,
                    ),
                    SizedBox(height: 16.h),
                    TextWidget(
                      text: 'Confirm Password',
                      fontSize: 16,
                      color: AppColors.whiteColor.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField2(
                      controller: signUpController.confirmPaassText,
                      max: 1,
                      hintText: '*********',
                      obscureText: true,
                      validator: signUpController.validatePasswordMatch,
                    ),
                    SizedBox(height: 30.h),
                    Obx(() => signUpController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          )
                        : CustomButton(
                            text: "Sign Up",
                            textColor: const Color(0XFF0D0D0C),
                            onPressed: () {
                              if (signInFormKey.currentState!.validate()) {
                                signUpController.signUp();
                              }
                            },
                            backgroundColor: const Color(0XFFFFDF00),
                            borderRadius: 40,
                          )),
                    SizedBox(height: 26.h),
                    Center(
                      child: Text(
                        "Or Sign up with",
                        style: textStyle(
                          14.sp,
                          AppColors.whiteColor.withOpacity(0.85),
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    signUpWithSocialMedia(socialLogin),
                  ],
                ),
                SizedBox(height: 50.h),
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
                          AppColors.whiteColor
                              .withOpacity(0.9)
                              .withOpacity(0.85),
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
                            Get.toNamed(AppRoute.loginScreen);
                          },
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

  signUpWithSocialMedia(SocialLogin sociallogin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            sociallogin.googleSignIn();
          },
          child: Container(
            padding: EdgeInsets.all(18.sp),
            decoration: BoxDecoration(
              border: Border.all(width: 1.sp, color: const Color(0xFF737268)),
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
          onTap: () {
            sociallogin.loginWithFacebook();
          },
          child: Container(
            padding: EdgeInsets.all(18.sp),
            decoration: BoxDecoration(
              border: Border.all(width: 1.sp, color: const Color(0xFF737268)),
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
    );
  }
  // void _register() async {
  //   if(customerSignUpKey.currentState!.validate()) {
  //     // if(authController.passwordController.value.text != authController.confirmPasswordController.value.text){
  //       ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
  //         content: Text('password_and_confirm_does_not_match'.tr),
  //         behavior: SnackBarBehavior.floating,
  //         backgroundColor: Colors.red,
  //       ));
  //     // }else{
  //     //   authController.registration();
  //     // }
  //   }
  // }
}
