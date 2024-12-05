import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

class CustomProfileViewCard extends StatelessWidget {
  const CustomProfileViewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  image: const DecorationImage(
                      image: AssetImage(
                        Assetpath.women,
                      ),
                      fit: BoxFit.fill)),
            ),
          ),
          Positioned(top: 20, left: -1, child: Image.asset(Assetpath.level)),
        ],
      ),
    );
  }
}
