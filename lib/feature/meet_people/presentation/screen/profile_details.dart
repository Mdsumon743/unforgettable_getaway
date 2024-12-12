import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/widget/build_details.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/widget/custom_circle_button.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const SizedBox(),
            expandedHeight: 350.h,
            floating: true,
            scrolledUnderElevation: 0,
            flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1,
                background: Image.asset(
                  Assetpath.profile1,
                  fit: BoxFit.fill,
                  width: double.infinity,
                )),
          ),
          buildDetails()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.all(15.r),
        margin: EdgeInsets.symmetric(horizontal: 60.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            color: const Color(0xff1A1110),
            boxShadow: [
              BoxShadow(
                  color: Colors.white38.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(2, 10))
            ]),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomCircleButton(
                size: false,
                iconData: Icon(
                  Icons.close,
                  size: 24,
                )),
            CustomCircleButton(
                size: true,
                iconData: Icon(
                  Icons.message,
                  size: 34,
                )),
            CustomCircleButton(
                size: false,
                iconData: Icon(
                  Icons.favorite_sharp,
                  size: 24,
                )),
          ],
        ),
      ),
    );
  }
}
