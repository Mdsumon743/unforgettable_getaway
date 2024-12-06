import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

class CustomProfileViewCard extends StatelessWidget {
  const CustomProfileViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.r),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          SizedBox(
            width: 180.w,
            height: 240.h,
          ),
          Positioned(
            left: 3,
            child: Container(
              height: 220.h,
              width: 160.w,
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: const DecorationImage(
                      image: AssetImage(
                        Assetpath.women,
                      ),
                      fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [SvgPicture.asset('assets/images/love.svg')],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextPopins(
                            text: "Dakota Jonas, 21 🇦🇺 ",
                            fontWeight: FontWeight.w600,
                            size: 13.sp,
                            color: Colors.white,
                          ),
                          Container(
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
                          CustomTextPopins(
                            text: "Malbourne, Australia",
                            size: 11.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(Assetpath.locationon),
                          CustomTextPopins(
                            text: "3 Km Away from you",
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
              top: 20,
              left: -1,
              child: SvgPicture.asset("assets/images/level.svg")),
        ],
      ),
    );
  }
}
