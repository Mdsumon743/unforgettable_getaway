import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircleButton extends StatelessWidget {
  final Icon iconData;
  final bool size;
  const CustomCircleButton(
      {super.key, required this.iconData, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: size ? EdgeInsets.all(20.r) : EdgeInsets.all(10.r),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffFFDF00),
      ),
      child: iconData,
    );
  }
}
