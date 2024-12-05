import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_appbar.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_inter.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/widget/custom_profile_view_card.dart';

class MeetPeople extends StatelessWidget {
  const MeetPeople({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.r),
          child: Column(
            children: [
              CustomTextIner(
                text: "Nearest people around you ⭐",
                fontWeight: FontWeight.w500,
                size: 16.sp,
              ),
              SizedBox(
                height: 20.h,
              ),
              const CustomProfileViewCard()
               
            ],
          ),
        ),
      ),
    );
  }
}
