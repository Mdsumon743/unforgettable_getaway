import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';

class ProgressBar extends StatelessWidget {
  final double width;
  const ProgressBar({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 10.h,
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) => Container(
              width: constraints.maxWidth * width,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          const Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
