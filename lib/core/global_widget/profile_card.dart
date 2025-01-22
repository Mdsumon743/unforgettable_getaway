// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';

class ProfileCard extends StatelessWidget {
  final String? name;
  final String? age;
  final String? profile;
  final String? location;
  final String? distance;
  final String? conuntryCode;
  final VoidCallback? onTap;
  final VoidCallback? onTapFavorite;

  const ProfileCard({
    super.key,
    this.name,
    this.age,
    this.profile,
    this.location,
    this.distance,
    this.onTap,
    this.onTapFavorite,
    this.conuntryCode,
  });

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return SizedBox(
      width: 230.w,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.network(
                    profile ??
                        'https://a.storyblok.com/f/191576/1200x800/a3640fdc4c/profile_picture_maker_before.webp',
                    height: 300,
                    width: size * 0.57,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
            ],
          ),
          Positioned(
            left: 25.w,
            bottom: 10,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name != null ? '$name,$age,' : 'Leo Cole, 24,',
                      style: textStyle(
                        14.sp,
                        AppColors.whiteColor,
                        FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    CountryFlag.fromLanguageCode(
                      conuntryCode ?? 'en',
                      width: 30.w,
                      height: 16.h,
                    ),
                    SizedBox(width: 16.w),
                    Container(
                      width: 16.w,
                      height: 16.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF17B26A),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/location_town.png",
                      width: 16.w,
                      height: 16.h,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      location ?? "Toronto, Canada",
                      style: textStyle(
                        11.sp,
                        AppColors.whiteColor.withOpacity(0.9),
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/distance.png",
                      width: 16.w,
                      height: 16.h,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      distance ?? "5 Km Away from you",
                      style: textStyle(
                        11.sp,
                        AppColors.whiteColor.withOpacity(0.9),
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            left: 8.w,
            child: Image.asset('assets/images/card.png'),
          ),
          Positioned(
            top: 10,
            right: 40.w,
            child: GestureDetector(
              onTap: onTapFavorite,
              child: Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                    color: AppColors.darkBrown.withOpacity(0.2),
                    shape: BoxShape.circle),
                child: const Icon(
                  Icons.favorite_border,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
