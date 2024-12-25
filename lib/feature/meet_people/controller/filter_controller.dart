import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/const/const.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

class FilterController extends GetxController {
  var selectedCountry = "".obs;

  void updateCountry(String country) {
    selectedCountry.value = country;
    
  }

  void showCountryPicker(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 4.h,
              width: 86.w,
              decoration: BoxDecoration(
                  color: const Color(0xff333329),
                  borderRadius: BorderRadius.circular(25.r)),
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextPopins(
              text: "Filter",
              color: Colors.black,
              fontWeight: FontWeight.w600,
              size: 24.sp,
            ),
            const SizedBox(height: 20),
            Obx(() {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextPopins(
                      text: "Select Country",
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      size: 18.sp,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedCountry.value,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          updateCountry(newValue);
                        }
                      },
                      items: Const.countries
                          .map<DropdownMenuItem<String>>((String country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                      isExpanded: true,
                      iconSize: 30,
                      icon: const Icon(Icons.arrow_drop_down),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                      dropdownColor: Colors.grey[200],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.amber.withOpacity(.02),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xff737268))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                const BorderSide(color: Color(0xff737268))),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      children: [
                        Image.asset(Assetpath.near),
                        SizedBox(
                          width: 5.w,
                        ),
                        CustomTextPopins(
                          text: "Use my current location",
                          color: const Color(0xff8C7B00),
                          size: 16.sp,
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                    color: const Color(0xffFFDF00),
                    borderRadius: BorderRadius.circular(48.r),
                  ),
                  child: Center(
                    child: CustomTextPopins(
                      text: "Apply Filters",
                      fontWeight: FontWeight.w500,
                      size: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15.r),
                  decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(48.r),
                      border: Border.all(color: const Color(0xff8C7B00))),
                  child: Center(
                    child: CustomTextPopins(
                      text: "Reset Filters",
                      fontWeight: FontWeight.w500,
                      size: 16.sp,
                      color: const Color(0xff8C7B00),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
