import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';

class SelectButton extends StatelessWidget {
  final String tittle;
  final String sub;
  final String image;
  const SelectButton(
      {super.key,
      required this.tittle,
      required this.sub,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), color: Colors.white),
      child: Center(
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Image.asset(image,height: 64.h,width: 64.w,),
          title: CustomTextPopins(
            text: tittle,
            fontWeight: FontWeight.w600,
            size: 16.sp,
            color: Colors.black,
          ),
          subtitle: CustomTextPopins(
            text: sub,
            fontWeight: FontWeight.w300,
            size: 12.sp,
            color: const Color(0xff4A4A4A),
          ),
          trailing: Radio(
            value: true,
            groupValue: false,
            onChanged: (value) {},
          ),
        ),
      ),
    );
  }
}
