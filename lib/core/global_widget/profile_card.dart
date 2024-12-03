import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

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
                Text(
                  "Leo Cole, 24 🇨🇦",
                  style: textStyle(
                    14.sp,
                    AppColors.whiteColor,
                    FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    SizedBox(width: 5.w),
                    Text(
                      "Toronto, Canada",
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
                    const Icon(Icons.directions_walk,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(
                      "5 Km Away from you",
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
            child: Container(
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                  color: AppColors.darkBrown.withOpacity(0.2),
                  shape: BoxShape.circle),
              child: const Icon(
                Icons.favorite_border,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = AppColors.yellowColor;

    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
