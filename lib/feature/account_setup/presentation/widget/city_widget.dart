import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
import 'package:unforgettable_getaway/feature/account_setup/controller/city_controller.dart';

class CityWidget extends StatelessWidget {
  const CityWidget({
    super.key,
    required this.cityController,
    required this.city,
  });

  final CityController cityController;
  final String city;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cityController.selectCity(city);
      },
      child: Center(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16.h),
          alignment: Alignment.center,
          color: city == cityController.selectedCity.value
              ? Colors.white10
              : Colors.transparent,
          padding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 12.w,
          ),
          child: Text(
            city,
            style: textStyle(
              16.sp,
              city == cityController.selectedCity.value
                  ? AppColors.whiteColor
                  : AppColors.whiteColor.withOpacity(0.9),
              city == cityController.selectedCity.value
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
