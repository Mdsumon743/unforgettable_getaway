// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/global_widget/custom_text_popins.dart';

class CustomPayment extends StatelessWidget {
  final String title;
  final String img;
  final double height;
  final double weight;
  final bool isSelected;
  final VoidCallback onTap;
  const CustomPayment({
    super.key,
    required this.title,
    required this.img,
    required this.isSelected,
    required this.onTap,
    required this.height,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(0.r),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xff8c7B00) : Colors.transparent,
            borderRadius: BorderRadius.circular(4.r), // Rounded corners
            border: Border.all(
              color: Colors.white.withOpacity(0.6),
              width: 1, // Border width
            ),
          ),
          child: ListTile(
            onTap: onTap,
            leading: Transform.scale(
              scale: 1.5,
              child: Radio(
                value: title,
                groupValue: isSelected ? title : '',
                onChanged: (_) => onTap(),
                activeColor: const Color(0xffFFDF00),
              ),
            ),
            title: CustomTextPopins(
              text: title,
              size: 16.h,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            trailing: Image.asset(
              img,
              height: height,
              width: weight,
            ),
          ),
        ));
  }
}
