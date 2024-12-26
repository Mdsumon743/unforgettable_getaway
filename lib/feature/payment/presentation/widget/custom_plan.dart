import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/global_widget/custom_text_popins.dart';

class CustomPlan extends StatelessWidget {
  final String tittle;
  final String sub;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomPlan({
    super.key,
    required this.tittle,
    required this.sub,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 98.h,
        width: 335.w,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff8C7B00) : Colors.transparent,
          border: Border.all(
            width: 1,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Center(
          child: ListTile(
            title: CustomTextPopins(
              text: tittle,
              size: 20.h,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            subtitle: CustomTextPopins(
              text: sub,
              size: 24.h,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            trailing: Transform.scale(
              scale: 1.5,
              child: Radio(
                value: tittle,
                groupValue:isSelected?tittle:'',
                onChanged: (_) => onTap(),
                activeColor: const Color(0xffFFDF00),
              ),
            ),

          ),
        ),
      ),
    );
  }
}
