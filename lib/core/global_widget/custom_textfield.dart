import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: false,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      validator: validator,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: textStyle(14.sp, AppColors.whiteColor.withOpacity(0.9).withOpacity(0.6), FontWeight.w300),
        filled: true,
        fillColor: AppColors.yellowColor.withOpacity(0.01),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.whiteColor.withOpacity(0.8),
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.whiteColor.withOpacity(0.8),
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
           color: AppColors.whiteColor.withOpacity(0.8),
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
