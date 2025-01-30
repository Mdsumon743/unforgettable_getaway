import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

aboutMe(String title, String title2, String image) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 20.r),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Image.asset(
                image,
                height: 20.h,
                width: 20.w,
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10.w, // Add spacing between the columns
        ),
        Flexible(
          child: Text(
            title2,
            overflow: TextOverflow.ellipsis, // Ensure this text does not overflow
            style: GoogleFonts.poppins(
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.w400,
                fontSize: 16.sp),
          ),
        )
      ],
    ),
  );
}
