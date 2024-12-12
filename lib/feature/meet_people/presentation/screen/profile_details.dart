import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const SizedBox(),
            expandedHeight: 380.h,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
              Assetpath.profile1,
              fit: BoxFit.fill,
              width: double.infinity,
            )),
          ),
          buildDetails()
        ],
      ),
    );
  }
}

Widget buildDetails() => SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r))),
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
                  text: "Dakota Jonas, 21",
                  fontWeight: FontWeight.w600,
                  size: 20.sp,
                  color: Colors.black,
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
                  text: "Cartogena, Colombia  🇨🇴",
                  size: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff737268),
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
                  color: const Color(0xff737268),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextPopins(
              text: "About",
              color: Colors.black,
              fontWeight: FontWeight.w600,
              size: 18.sp,
            )
          ],
        ),
      ),
    );
