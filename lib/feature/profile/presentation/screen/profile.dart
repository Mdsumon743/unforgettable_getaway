import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/widget/favorited.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/widget/photo_gridview.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/widget/subcription_card.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/widget/verification.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1A1110),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xff1A1110),
        centerTitle: true,
        title: CustomTextPopins(
          text: "Profile",
          fontWeight: FontWeight.w500,
          size: 24.sp,
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.r),
          child: Center(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 100.h,
                      width: 120.w,
                    ),
                    CircleAvatar(
                        radius: 60.h,
                        backgroundImage:
                            const AssetImage("assets/images/2.png")),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        padding: EdgeInsets.all(3.r),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xff333329)),
                        child: Center(
                          child: Image.asset(Assetpath.edit),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextPopins(
                      text: "Sophie Lynn, 24",
                      fontWeight: FontWeight.w600,
                      size: 26.sp,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    SvgPicture.asset(Assetpath.verified)
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    fovoritedMe("42", "Favorited Me"),
                    SizedBox(
                      width: 30.w,
                    ),
                    fovoritedMe("12", "Favorite List"),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                const Divider(
                  height: 0.5,
                  thickness: 0.5,
                ),
                const SubcriptionCard(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextPopins(
                          text: "Photo",
                          fontWeight: FontWeight.w600,
                          size: 20.sp,
                          color: Colors.white,
                        ),
                        CustomTextPopins(
                          text: "Pick some taht show the real you",
                          fontWeight: FontWeight.w400,
                          size: 14.sp,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
                  child: const PhotoGridview(),
                ),
                SizedBox(
                  height: 10.h,
                ),
               const  Verification(),
                SizedBox(
                  height: 10.h,
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
