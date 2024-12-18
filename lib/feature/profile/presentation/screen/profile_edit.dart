import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/country_list.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_textfield.dart';

import '../../../../core/global_widget/custom_text_popins.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xff1A1110),
        centerTitle: true,
        title: CustomTextPopins(
          text: "Edit Profile",
          fontWeight: FontWeight.w500,
          size: 24.sp,
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
      backgroundColor: const Color(0xff1A1110),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                    radius: 60.h,
                    backgroundImage: const AssetImage("assets/images/2.png")),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 40.h,
                  width: 180.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(
                          color: Colors.white.withOpacity(.1), width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      CustomTextPopins(
                        text: "Add Photo",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        size: 16.sp,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextPopins(
                      text: "Basic",
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextPopins(
                      text: "Username",
                      fontWeight: FontWeight.w400,
                      size: 14.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const CustomTextField(
                      colorTrue: true,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextPopins(
                      text: "Full name*",
                      fontWeight: FontWeight.w400,
                      size: 14.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const CustomTextField(
                      colorTrue: true,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextPopins(
                      text: "Country*",
                      fontWeight: FontWeight.w400,
                      size: 14.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    countrylist(true),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextPopins(
                      text: "Language*",
                      fontWeight: FontWeight.w400,
                      size: 14.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const CustomTextField(
                      colorTrue: true,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextPopins(
                      text: "Gender*",
                      fontWeight: FontWeight.w400,
                      size: 14.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const CustomTextField(
                      suffix: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextPopins(
                      text: "Age*",
                      fontWeight: FontWeight.w400,
                      size: 14.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const CustomTextField(
                      suffix: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextPopins(
                      text: "Height*",
                      fontWeight: FontWeight.w400,
                      size: 14.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const CustomTextField(
                      suffix: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextPopins(
                      text: "Work",
                      fontWeight: FontWeight.w400,
                      size: 14.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const CustomTextField(
                      suffix: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  text: "Update Profile",
                  borderRadius: 30.r,
                  backgroundColor: const Color(0xffFFDF00),
                  textColor: Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
