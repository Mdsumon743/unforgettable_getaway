import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/chip_list.dart';
import '../../../../core/global_widget/custom_text_popins.dart';
import '../../../../core/utils/assetpath.dart';
import 'gallery_gridview.dart';

Widget buildDetails({
  String? name,
  String? age,
  String? address,
  String? flag,
  String? about,
  List? intersted,
  String? height,
  String? status,
  String? interst,
  String? relationshipStatus,
  String? language,
  String? work,
  List? gellery,
}) {
  return SliverToBoxAdapter(
    child: Container(
      padding: EdgeInsets.all(15.r),
      decoration: const BoxDecoration(
        color: Color(0xff1A1110),
      ),
      child: Column(
        children: [
          Container(
            height: 4.h,
            width: 86.w,
            decoration: BoxDecoration(
                color: const Color(0xff333329),
                borderRadius: BorderRadius.circular(25.r)),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              CustomTextPopins(
                text: "$name, $age",
                fontWeight: FontWeight.w600,
                size: 20.sp,
                color: Colors.white,
              ),
              SizedBox(
                width: 5.w,
              ),
              SvgPicture.asset("assets/icons/verified.svg"),
              SizedBox(
                width: 5.w,
              ),
              Container(
                margin: const EdgeInsets.only(left: 2),
                width: 12.w,
                height: 12.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF17B26A),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Image.asset(
                height: 20.h,
                width: 20.w,
                Assetpath.onLocation,
                color: const Color(0xffD9CA6C),
              ),
              SizedBox(
                width: 5.w,
              ),
              CustomTextPopins(
                text: "$address $flag",
                size: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ],
          ),
          Row(
            children: [
              Image.asset(
                height: 20.h,
                width: 20.w,
                Assetpath.locationon,
                color: const Color(0xffD9CA6C),
              ),
              SizedBox(
                width: 5.w,
              ),
              CustomTextPopins(
                text: "3 Km Away from you",
                size: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomTextPopins(
              text: "About",
              color: Colors.white,
              fontWeight: FontWeight.w600,
              size: 18.sp,
            ),
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text:
                    "Hey! I’m Dakota, a free spirit who loves exploring new places, meeting new people, and enjoying life to the fullest. Whether I’m at the....",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400)),
            TextSpan(
                text: "Read More",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xffFFF6B2),
                ))
          ])),
          SizedBox(
            height: 10.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomTextPopins(
              text: "Interest",
              color: Colors.white,
              fontWeight: FontWeight.w600,
              size: 18.sp,
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: intersted?.length,
            itemBuilder: (context, index) {
              var favoriteListItem = intersted?[index];
              return Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: -5.0,
                  runAlignment: WrapAlignment.spaceAround,
                  children: [
                    buildChip(favoriteListItem, size: 10),
                  ],
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 3.0,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomTextPopins(
              text: "Dakota’s Info",
              color: Colors.white,
              fontWeight: FontWeight.w600,
              size: 18.sp,
            ),
          ),
          buildRow("Age", "$age"),
          buildRow("Height", "$height"),
          buildRow("Relationship Status", "$relationshipStatus"),
          buildRow("Language", "$language"),
          buildRow("Work", "$work"),
          SizedBox(
            height: 10.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomTextPopins(
              text: "Gallery",
              color: Colors.white,
              fontWeight: FontWeight.w600,
              size: 18.sp,
            ),
          ),
          const GalleryGridview()
        ],
      ),
    ),
  );
}

buildRow(String tittle, String tiitle2) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.r),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          tittle,
          style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w400,
              fontSize: 14.sp),
        ),
        Text(
          tiitle2,
          style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w400,
              fontSize: 14.sp),
        )
      ],
    ),
  );
}
