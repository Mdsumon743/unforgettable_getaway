import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 40.h,
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            const ProgressBar(
              width: 0.25,
            ),
            SizedBox(height: 20.h),
            Text(
              'Oh hey! Let’s start \nwith an intro',
              style: textStyle(
                30.sp,
                AppColors.darkBrown1,
                FontWeight.w700,
              ),
            ),
            SizedBox(height: 36.h),
            Text(
              'Your first name',
              style: textStyle(
                20.sp,
                AppColors.darkBrown1,
                FontWeight.w500,
              ),
            ),
            SizedBox(height: 16.h),
            inputTextField(),
            SizedBox(height: 30.h),
            Text(
              'Your birthday',
              style: textStyle(
                20.sp,
                AppColors.darkBrown1,
                FontWeight.w500,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: textStyle(
                          14.sp,
                          AppColors.mediumDarkGrey,
                          FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      inputTextField(),
                    ],
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Month',
                        style: textStyle(
                          14.sp,
                          AppColors.mediumDarkGrey,
                          FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      inputTextField(),
                    ],
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Year',
                        style: textStyle(
                          14.sp,
                          AppColors.mediumDarkGrey,
                          FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      inputTextField(),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'It’s never too early to count down',
              style: textStyle(
                16.sp,
                AppColors.mediumDarkGrey,
                FontWeight.w500,
              ),
            ),
            CustomButton(
              text: 'Next',
              textColor: AppColors.darkBrown1,
              backgroundColor: AppColors.semiTransparent,
              onPressed: () {},
              borderRadius: 40,
            )
          ],
        ),
      ),
    );
  }

  inputTextField() {
    return TextField(
      decoration: InputDecoration(
        fillColor: AppColors.semiTransparent.withOpacity(0.03),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.semiTransparent.withOpacity(0.5),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.semiTransparent.withOpacity(0.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.semiTransparent.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
