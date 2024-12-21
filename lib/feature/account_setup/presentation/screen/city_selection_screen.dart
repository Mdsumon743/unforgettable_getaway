import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
import 'package:unforgettable_getaway/feature/account_setup/controller/city_controller.dart';
import '../../controller/country_selection_controller.dart';
import '../../domain/service/service.dart';

class CitySelectionScreen extends StatelessWidget {
  const CitySelectionScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cityController = Get.put(CityController());
    final citiesController = Get.put(CitiesController());
    final countrySController = Get.put(CountrySelectionController());

    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    'Choose your City',
                    style: textStyle(
                      24.sp,
                      AppColors.whiteColor,
                      FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Divider(
                    thickness: 1,
                    color: AppColors.whiteColor.withOpacity(0.2),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            countrySController.flag,
                            style: const TextStyle(fontSize: 24),
                          ),
                          SizedBox(width: 8.0.w),
                          Text(
                            countrySController.selectedCountry.value,
                            style: textStyle(
                              16.sp,
                              AppColors.whiteColor.withOpacity(0.9),
                              FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.check_circle,
                        color: AppColors.yellowColor,
                        size: 24.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Divider(
                    thickness: 1,
                    color: AppColors.whiteColor.withOpacity(0.2),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Choose City',
                    style: textStyle(
                      18.sp,
                      AppColors.whiteColor.withOpacity(0.95),
                      FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.whiteColor.withOpacity(0.8),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.0.r),
                    ),
                    child: Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cityController.selectedCity.value,
                              style: textStyle(
                                  16.sp, AppColors.whiteColor, FontWeight.w400),
                            ),
                            GestureDetector(
                              onTap: () {
                                cityController.toggleMethod();
                              },
                              child: cityController.arrowDown.value
                                  ? const Icon(
                                      Icons.arrow_drop_down,
                                      color: AppColors.whiteColor,
                                    )
                                  : const Icon(
                                      Icons.arrow_drop_up,
                                      color: AppColors.whiteColor,
                                    ),
                            )
                          ],
                        )),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
            Obx(
              () => cityController.arrowDown.value
                  ? citiesController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.51,
                          child: ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: citiesController.cities.length,
                            itemBuilder: (context, index) {
                              var city = citiesController.cities[index];
                              return InkWell(
                                onTap: () {
                                  cityController.selectedCity.value = city;
                                  cityController.selectCity(city);
                                },
                                child: Center(
                                  child: Obx(
                                    () => Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 16.h),
                                      alignment: Alignment.center,
                                      color:
                                          cityController.selectedCity.value ==
                                                  citiesController.cities[index]
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
                                          city ==
                                                  cityController
                                                      .selectedCity.value
                                              ? AppColors.whiteColor
                                              : AppColors.whiteColor
                                                  .withOpacity(0.9),
                                          city ==
                                                  cityController
                                                      .selectedCity.value
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                  : const SizedBox(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 10.h,
              ),
              child: Obx(() => CustomButton(
                    text: 'Next',
                    textColor:
                        cityController.selectedCity.value == "Select City"
                            ? AppColors.darkBrown1
                            : Colors.black,
                    backgroundColor:
                        cityController.selectedCity.value == "Select City"
                            ? AppColors.whiteColor.withOpacity(0.5)
                            : AppColors.yellowColor,
                    onPressed: () {
                      if (cityController.selectedCity.value == "Select City") {
                        debugPrint("select city first");
                      } else {
                        Get.toNamed(AppRoute.namebirthScreen);
                      }
                    },
                    borderRadius: 40,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
