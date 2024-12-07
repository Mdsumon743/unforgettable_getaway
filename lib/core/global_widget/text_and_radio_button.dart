import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';

class TextAndRadioButton extends StatelessWidget {
  const TextAndRadioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.mediumDarkGrey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Women',
            style: textStyle(
              16.sp,
              const Color(0xFF333329),
              FontWeight.w500,
            ),
          ),
          SizedBox(width: 8.0.w),
          Radio(
            value: true,
            groupValue: null,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
