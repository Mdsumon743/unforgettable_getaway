import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
import 'package:unforgettable_getaway/feature/account_setup/controller/account_controller.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/widget/progress_bar.dart';

class NameBirthdayScreen extends StatelessWidget {
  const NameBirthdayScreen({super.key});

  int calculateAgeInYearsMonthsDays(int year, int month, int day) {
    final DateTime currentDate = DateTime.now();

    int years = currentDate.year - year;

    if (currentDate.month < month ||
        (currentDate.month == month && currentDate.day < day)) {
      years--;
    }

    int months = currentDate.month - month;
    if (months < 0) {
      months += 12;
    }

    int days = currentDate.day - day;
    if (days < 0) {
      final previousMonth = DateTime(currentDate.year, currentDate.month, 0);
      days += previousMonth.day;
    }

    debugPrint('Age: $years years, $months months, $days days');
    return years;
  }

  @override
  Widget build(BuildContext context) {
    final acccountController = Get.put(AccountController());
    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 50.h,
            left: 16.w,
            right: 16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 10.h,
              ),
              const ProgressBar(
                width: 0.25,
              ),
              SizedBox(height: 30.h),
              Text(
                'Oh hey! Let’s start \nwith an intro',
                style: textStyle(
                  30.sp,
                  AppColors.whiteColor,
                  FontWeight.w700,
                ),
              ),
              SizedBox(height: 36.h),
              Text(
                'Your first name',
                style: textStyle(
                  20.sp,
                  AppColors.whiteColor.withOpacity(0.95),
                  FontWeight.w500,
                ),
              ),
              SizedBox(height: 16.h),
              nameTextField(acccountController),
              SizedBox(height: 30.h),
              Text(
                'Your birthday',
                style: textStyle(
                  20.sp,
                  AppColors.whiteColor.withOpacity(0.95),
                  FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h),
              birthDayDateSelection(acccountController, context),
              SizedBox(height: 16.h),
              Text(
                'It’s never too early to count down',
                style: textStyle(
                  16.sp,
                  AppColors.whiteColor.withOpacity(0.8),
                  FontWeight.w500,
                ),
              ),
              SizedBox(height: 50.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.error_outline, color: Color(0xFFFF7167)),
                  SizedBox(width: 5.w),
                  Text(
                    'You must be at least 18 years old to access\n \'Meet People\'',
                    style: textStyle(
                      14.sp,
                      const Color(0xFFFF7167).withOpacity(0.8),
                      FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 130.h),
              Obx(() => CustomButton(
                    text: 'Next',
                    textColor: AppColors.darkBrown1,
                    backgroundColor: acccountController.userAge < 18
                        ? AppColors.whiteColor.withOpacity(0.5)
                        : AppColors.yellowColor,
                    onPressed: () {
                      if (acccountController.userAge >= 18) {
                        Get.toNamed(AppRoute.gender);
                      } else {}
                    },
                    borderRadius: 40,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  birthDayDateSelection(
    AccountController acccountController,
    BuildContext context,
  ) {
    return Row(
      children: [
        Obx(
          () => dateSelection(
            acccountController,
            acccountController.selectedDate.value?.day.toString() ?? "",
            "Date",
            'day',
            2,
            context,
          ),
        ),
        SizedBox(width: 14.w),
        Obx(
          () => dateSelection(
            acccountController,
            acccountController.selectedDate.value?.month.toString() ?? "",
            "Month",
            'month',
            2,
            context,
          ),
        ),
        SizedBox(width: 14.w),
        Obx(
          () => dateSelection(
            acccountController,
            acccountController.selectedDate.value?.year.toString() ?? "",
            "Year",
            'year',
            3,
            context,
          ),
        ),
      ],
    );
  }

  dateSelection(
    AccountController acccountController,
    String date,
    String label,
    String type,
    int flex,
    BuildContext context,
  ) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textStyle(
              14.sp,
              AppColors.whiteColor.withOpacity(0.9),
              FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () {
              acccountController.selectDate(context, type);
            },
            child: Container(
              height: 50,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.01),
                border: Border.all(
                  color: AppColors.whiteColor.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                date,
                style: const TextStyle(color: AppColors.whiteColor),
              ),
            ),
          )
        ],
      ),
    );
  }

  nameTextField(AccountController acccountController) {
    return TextField(
      controller: acccountController.nameEditingController,
      style: textStyle(
        16.sp,
        AppColors.whiteColor,
        FontWeight.w400,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.sp),
        fillColor: AppColors.whiteColor.withOpacity(0.01),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.whiteColor.withOpacity(0.8),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.whiteColor.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.whiteColor.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
