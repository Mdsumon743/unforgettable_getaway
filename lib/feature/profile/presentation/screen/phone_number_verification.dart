// ignore_for_file: deprecated_member_use

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/feature/profile/controller/phone_number_input.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/screen/phone_number_verify.dart';

import '../../../../core/global_widget/custom_text_popins.dart';

class PhoneNumberVerification extends StatelessWidget {
  const PhoneNumberVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final PhoneVerificationController phoneController =
        Get.put(PhoneVerificationController());

    return Scaffold(
      backgroundColor: const Color(0xff1A1110),
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
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextPopins(
                textAlign: TextAlign.start,
                text: "Enter Your Number to\nVerify Your Account",
                fontWeight: FontWeight.w700,
                size: 24.sp,
                color: Colors.white,
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomTextPopins(
                textAlign: TextAlign.start,
                text:
                    """When someone is verified, it means they’re for real. We’ll send a secure 6-digit code to verify your number and help ensure a genuine experience.""",
                fontWeight: FontWeight.w400,
                size: 14.sp,
                color: Colors.white,
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextPopins(
                        text: "Country",
                        fontWeight: FontWeight.w500,
                        size: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CountryCodePicker(
                          barrierColor: Colors.transparent,
                          onChanged: (code) {
                            phoneController.updateCountryCode(code.dialCode!);
                          },
                          initialSelection: 'US',
                          favorite: const ['+1', 'US'],
                          showCountryOnly: false,
                          showFlag: true,
                          dialogBackgroundColor: Colors.white,
                          backgroundColor: Colors.white,
                          showOnlyCountryWhenClosed: false,
                          textStyle: const TextStyle(color: Colors.white),
                          searchDecoration: const InputDecoration(
                            hintText: "Search country",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        CustomTextPopins(
                          text: "Phone Number",
                          fontWeight: FontWeight.w500,
                          size: 14.sp,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        TextField(
                          onChanged: (value) {
                            phoneController.updatePhoneNumber(value);
                          },
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                          ),
                        ),
                      ])),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5.w,
                ),
                CustomTextPopins(
                    fontWeight: FontWeight.w400,
                    size: 11.sp,
                    color: const Color(0xffFFFDE7),
                    text:
                        "We never share this with anyone and it\nwon’t be on your profile"),
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
            )
          ],
        ),
      ),
    );
  }
}
