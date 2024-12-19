import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
import 'package:unforgettable_getaway/feature/account_setup/controller/account_controller.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/screen/interest_selection_screen.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/widget/progress_bar.dart';

final List<String> heights = [
  '5\'1"',
  '5\'2"',
  '5\'3"',
  '5\'4"',
  '5\'5"',
  '5\'6"',
  '5\'7"'
];

class HeightPickerScreen extends StatelessWidget {
  const HeightPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountController = Get.put(AccountController());
    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  const ProgressBar(width: 0.75),
                  SizedBox(height: 26.h),
                  Text(
                    'Welcome Jhoney,',
                    style: textStyle(
                      30.sp,
                      AppColors.whiteColor,
                      FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Let's quickly gather a few details to get started. We'll dive into the important stuff shortly.",
                    style: textStyle(
                      16.sp,
                      const Color(0xFFFFFFFF).withOpacity(0.8),
                      FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Your height',
                    style: textStyle(
                      20.sp,
                      AppColors.whiteColor.withOpacity(0.95),
                      FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.53,
              child: Center(
                child: ListWheelScrollView.useDelegate(
                  physics: const FixedExtentScrollPhysics(),
                  itemExtent: 60,
                  onSelectedItemChanged: (index) {
                    accountController.selectHeight(index);
                    // setState(() {
                    //   selectedIndex = index;
                    //   debugPrint(selectedIndex.toString());
                    // });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      return Obx(() => Center(
                            child: index ==
                                    accountController.heightSelectedIndex.value
                                ? Container(
                                    height: 50.h,
                                    alignment: Alignment.center,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16.h),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor
                                            .withOpacity(.1),
                                        borderRadius:
                                            BorderRadius.circular(12.r)),
                                    child: Text(
                                      heights[index],
                                      style: textStyle(
                                        20.sp,
                                        AppColors.whiteColor,
                                        FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : Text(
                                    heights[index],
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      color: Colors.white38,
                                    ),
                                  ),
                          ));
                    },
                    childCount: heights.length,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  CustomButton(
                    text: 'Next',
                    textColor: AppColors.darkBrown1,
                    backgroundColor: AppColors.yellowColor,
                    onPressed: () {
                      // Get.to(() => const InterestSelectionScreen());
                      Get.toNamed(AppRoute.interestSelectionScreen);
                    },
                    borderRadius: 40,
                  ),
                  const SizedBox(height: 8.0),
                  CustomButton(
                    text: 'Skip',
                    textColor: AppColors.yellowColor,
                    backgroundColor: AppColors.darkBrown,
                    onPressed: () {
                      // Get.to(() => const HeightPickerScreen());
                    },
                    borderRadius: 40,
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
