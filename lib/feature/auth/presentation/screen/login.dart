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
import 'package:unforgettable_getaway/feature/auth/controller/login_controller.dart';
import 'package:unforgettable_getaway/feature/auth/controller/social_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();
    final LoginController loginController = Get.put(LoginController());
    final SocialLogin socialLogin = Get.put(SocialLogin());
    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      body: Form(
        key: loginFormKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 60.h),
                Image.asset('assets/images/logo_image.png'),
                SizedBox(height: 40.h),
                Text(
                  "Login",
                  style:
                      textStyle(24.sp, AppColors.whiteColor, FontWeight.w600),
                ),
                SizedBox(height: 40.h),
                Column(
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
                      controller: loginController.emailText,
                      hintText: 'Enter your mail address',
                      validator: FormValidation.validateEmail,
                    ),
                    SizedBox(height: 20.h),
                    TextWidget(
                      text: 'Password',
                      fontSize: 16,
                      color: AppColors.whiteColor.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField2(
                      controller: loginController.passText,
                      obscureText: true,
                      hintText: '************',
                      max: 1,
                      validator: FormValidation.validatePassword,
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoute.forgetPpassword),
                          child: Text(
                            "ForgotPassword?",
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
                    SizedBox(height: 26.h),
                    Obx(
                      () => loginController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.amber,
                              ),
                            )
                          : CustomButton(
                              text: "Log in",
                              textColor: const Color(0XFF0D0D0C),
                              backgroundColor: const Color(0XFFFFDF00),
                              borderRadius: 40,
                              onPressed: () {
                                if (loginFormKey.currentState!.validate()) {
                                  loginController.logIn();
                                }
                              }),
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(height: 16.h),
                    Center(
                      child: Text(
                        "Or Login with",
                        style: textStyle(
                          14.sp,
                          AppColors.whiteColor.withOpacity(0.85),
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Center the icons horizontally
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            socialLogin.googleSignIn();
                          },
                          child: Container(
                            padding: EdgeInsets.all(20.sp),
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
                          onTap: () {
                            socialLogin.loginWithFacebook();
                          },
                          child: Container(
                            padding: EdgeInsets.all(20.sp),
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
                SizedBox(height: 60.h),
                bottomTextBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bottomTextBar() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: textStyle(
          14.sp,
          const Color(0xFFFFFCE5).withOpacity(0.85),
          FontWeight.w400,
        ),
        children: <TextSpan>[
          TextSpan(
            text: "Don’t have an account ?",
            style: textStyle(
              14.sp,
              AppColors.whiteColor.withOpacity(0.9).withOpacity(0.85),
              FontWeight.w400,
            ),
          ),
          TextSpan(
            text: ' Sign Up',
            style: GoogleFonts.poppins(
              color: const Color(0xFF8C7B00),
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Get.toNamed(AppRoute.signUpScreen);
              },
          ),
        ],
      ),
    );
  }
}
