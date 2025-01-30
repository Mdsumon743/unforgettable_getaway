import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
import 'package:unforgettable_getaway/feature/account_setup/controller/country_selection_controller.dart';
import 'package:unforgettable_getaway/feature/account_setup/controller/location_controller.dart';
import 'package:unforgettable_getaway/feature/account_setup/domain/service/service.dart';

class CountrySelectionScreen extends StatelessWidget {
  const CountrySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final countrySController = Get.put(CountrySelectionController());
    final citiesController = Get.put(CitiesController());
    // ignore: unused_local_variable
    final locationController = Get.put(LocationController());
    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12.w, top: 45.h, right: 12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose your Country',
                    style: textStyle(
                      24.sp,
                      AppColors.whiteColor,
                      FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: SizedBox(
                          height: 45.h,
                          child: TextField(
                            onChanged: (value) {
                              countrySController.searchCountry(value);
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white12,
                              hintText: 'Country / Region',
                              hintStyle: const TextStyle(color: Colors.white54),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.white54,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          'Cancel',
                          style: textStyle(
                              16.sp,
                              // ignore: deprecated_member_use
                              AppColors.whiteColor.withOpacity(0.8),
                              FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            const Divider(color: Colors.white12, thickness: 1),
            GetBuilder<CountrySelectionController>(builder: (controller) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.73,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  // shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    final country = countries[index];

                    if (countrySController.searchText.isNotEmpty &&
                        !country['name']!.toLowerCase().contains(
                            countrySController.searchText.toLowerCase())) {
                      return const SizedBox();
                    }

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListTile(
                            focusColor: Colors.amber,
                            contentPadding: EdgeInsets.zero,
                            leading: Text(
                              country['flag']!,
                              style: const TextStyle(fontSize: 24),
                            ),
                            title: Text(
                              country['name']!,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                            onTap: () {
                              debugPrint('Selected: ${country['name']}');
                              citiesController
                                  .fetchCities(country["name"].toString());
                              countrySController.selectCountry(
                                  true, country['name']!, country['flag']!);
                              Get.toNamed(
                                AppRoute.selectCity 
                              );
                            },
                          ),
                          const Divider(color: Colors.white12, thickness: 1),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
