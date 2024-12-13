import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  const TextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle(
        fontSize?.sp ?? 16.sp,
        color ?? Colors.black,
        fontWeight ?? FontWeight.w500,
      ),
    );
  }
}
