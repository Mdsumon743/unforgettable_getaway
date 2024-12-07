import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/screen/meet_people.dart';

class SearchLocation extends StatelessWidget {
  const SearchLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: const Column(
              children: [
                CustomTextFieldSearch(
                  keyboardType: TextInputType.text,
                  hintText: 'Search for people by city ',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xff737268),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldSearch extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Color? color;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextFieldSearch({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.textInputAction,
    this.color, this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fillColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all( color: const Color(0xff737268), width: 1.5)),
      child: TextFormField(
        textInputAction: textInputAction,
        onEditingComplete: () {
          Get.to(() => const MeetPeople());
        },
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        style: GoogleFonts.poppins(
            fontSize: 16.sp,
            color: color ?? const Color(0xff333329),
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
   
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: color ?? const Color(0xff333329),
                fontWeight: FontWeight.w400),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: InputBorder.none),
      ),
    );
  }
}
