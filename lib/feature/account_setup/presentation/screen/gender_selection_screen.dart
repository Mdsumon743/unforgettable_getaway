import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
import 'package:unforgettable_getaway/feature/account_setup/controller/account_controller.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/widget/progress_bar.dart';

class GenderSelectionScreen extends StatelessWidget {
  const GenderSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountController = Get.put(AccountController());
    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      appBar: AppBar(
        backgroundColor: AppColors.darkBrown,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProgressBar(width: 0.50),
                  SizedBox(height: 26.h),
                  Text(
                    'Welcome ${accountController.nameEditingController.text},',
                    style: textStyle(
                      30.sp,
                      AppColors.whiteColor,
                      FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Pick the gender that best describe you',
                    style: textStyle(
                      14.sp,
                      const Color(0xFFFFFFFF).withOpacity(0.8),
                      FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 36.h),
                  Text(
                    'Which Gender best\ndescribe you ?',
                    style: textStyle(
                      20.sp,
                      AppColors.whiteColor.withOpacity(0.95),
                      FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                    () => _radioButtonSection(0, 'Woman', accountController),
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                    () => _radioButtonSection(1, 'Men', accountController),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.error_outline, color: Color(0xFFFFFDE7)),
                      SizedBox(width: 5.w),
                      Text(
                        'You can always update this later',
                        style: textStyle(
                          14.sp,
                          const Color(0xFFFFFDE7).withOpacity(0.8),
                          FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 250.h,
              ),
              CustomButton(
                text: 'Next',
                textColor: AppColors.darkBrown1,
                backgroundColor: AppColors.yellowColor,
                onPressed: () {
                  Get.toNamed(AppRoute.height);
                },
                borderRadius: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  _radioButtonSection(int value, String text, AccountController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 60.h,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.whiteColor.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(12.r)),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: textStyle(16.sp, AppColors.whiteColor, FontWeight.w500),
            ),
            Radio(
              value: value,
              activeColor: AppColors.yellowColor,
              groupValue: controller.genderSelectedValue.value,
              onChanged: (int? value) {
                controller.updatedValueGender(value!);
              },
            )
          ],
        ),
      ),
    );
  }
}
