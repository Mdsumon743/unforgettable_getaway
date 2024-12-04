// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';

import 'package:unforgettable_getaway/core/utils/text_style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;
  final double width;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Icon? icon;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height = 48.0,
    this.width = double.infinity,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height.h,
        width: width.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.darkGrey,
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        child: Text(
          text,
          style: textStyle(
            fontSize ?? 18.sp,
            textColor ?? AppColors.yellowColor,
            fontWeight ?? FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
