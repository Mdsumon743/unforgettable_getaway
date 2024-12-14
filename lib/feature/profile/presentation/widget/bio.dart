import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_textfield.dart';

import '../../../../core/global_widget/custom_text_popins.dart';

class Bio extends StatelessWidget {
  const Bio({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController bio = TextEditingController();
    bio.text =
        """Hey, I’m Dakota! I’m all about adventure, laughter, and good vibes. Love exploring new places, trying new things, and meeting cool people. Looking for someone to share exciting moments and create lasting memories together!""";
    return Container(
      margin: EdgeInsets.all(10.r),
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.02)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomTextPopins(
              text: "Bio",
              fontWeight: FontWeight.w600,
              size: 20.sp,
              color: Colors.white,
            ),
            CustomTextPopins(
              text: "Edit",
              fontWeight: FontWeight.w400,
              size: 16.sp,
              decoration: TextDecoration.underline,
              color: const Color(0xffFFF6B2),
            ),
          ]),
          SizedBox(
            height: 10.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomTextPopins(
              text: "Write a fun & punchy intro about you",
              fontWeight: FontWeight.w400,
              size: 14.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextField(
            min: 4,
            controller: bio,
            colorTrue: true,
            
          ),
        ],
      ),
    );
  }
}
