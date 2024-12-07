import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_appbar.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_inter.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/screen/search_location.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/widget/custom_gridview_profile.dart';

import '../../../../core/utils/assetpath.dart';
import '../../controller/filter_controller.dart';

class MeetPeople extends StatelessWidget {
  const MeetPeople({super.key});

  @override
  Widget build(BuildContext context) {
    final FilterController filterController = Get.put(FilterController());
    final TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.darkBrown,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r))),
            child: Column(
              children: [
                CustomTextFieldSearch(
                  fillColor: const Color(0xff302827),
                  hintText: 'Cartagena, Colombia',
                  color: Colors.white,
                  controller: textEditingController,
                  prefixIcon: Image.asset(Assetpath.search),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        filterController.showCountryPicker(context);
                      },
                      child: Image.asset(Assetpath.filter)),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextIner(
                      text: "Nearest people around you ⭐",
                      fontWeight: FontWeight.w500,
                      size: 16.sp,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const CustomGridviewProfile()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffFFDF00),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
        onPressed: () {},
        child: SvgPicture.asset('assets/icons/sms.svg'),
      ),
    );
  }
}
