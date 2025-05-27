import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_animation_text.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/profile/controller/favorite_controller.dart';

class CustomProfileViewCard extends StatelessWidget {
  final String? userId;
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
      this.image,
      this.userId});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController = Get.put(FavoriteController());
    return Container(
      padding: EdgeInsets.all(5.r),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Stack(
        children: [
          SizedBox(
            width: 350.w,
            height: 250.h,
          ),
          Positioned(
            left: 3,
            child: Container(
              height: 240.h,
              width: 330.w,
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(
                      repeat: ImageRepeat.repeat,
                      image: CachedNetworkImageProvider(
                          image ?? "https://i.ibb.co.com/nrs3FjM/images.png"),
                      fit: BoxFit.fill)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            favoriteController.addFavoritList(userId ?? "");
                          },
                          child: SvgPicture.asset(
                              love ?? "assets/images/unlove.svg"))
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
                          SizedBox(
                            width: 5.w,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 2),
                            width: 10.w,
                            height: 10.h,
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
