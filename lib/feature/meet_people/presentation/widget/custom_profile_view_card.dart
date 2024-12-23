import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_animation_text.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

class CustomProfileViewCard extends StatelessWidget {
  final String? level;
  final String? love;
  final String? name;
  final String? age;
  final String? image;
  final String? country;
  final String? adress;
  final String? distance;
  const CustomProfileViewCard(
      {super.key,
      this.level,
      this.love,
      this.name,
      this.age,
      this.country,
      this.adress,
      this.distance,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.r),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Stack(
        children: [
          SizedBox(
            width: 170.w,
            height: 230.h,
          ),
          Positioned(
            left: 3,
            child: Container(
              height: 220.h,
              width: 160.w,
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                      repeat: ImageRepeat.repeat,
                      image: NetworkImage(
                          image ?? "https://i.ibb.co.com/nrs3FjM/images.png"),
                      fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(love ?? "assets/images/unlove.svg")
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextPopins(
                            max: 1,
                            textOverflow: TextOverflow.ellipsis,
                            text: "$name, $age $country ",
                            fontWeight: FontWeight.w600,
                            size: 13.sp,
                            color: Colors.white,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 2),
                            width: 8.w,
                            height: 8.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF17B26A),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(Assetpath.onLocation),
                          SizedBox(
                            width: 120.w,
                            child: CustomAnimationText(
                                text: "$adress",
                                textStyle: GoogleFonts.poppins(
                                    fontSize: 11.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(Assetpath.locationon),
                          CustomTextPopins(
                            text: "$distance",
                            size: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 10,
              left: -1,
              child: SvgPicture.asset(level ?? "assets/images/level.svg")),
        ],
      ),
    );
  }
}
