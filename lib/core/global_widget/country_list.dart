import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/const/const.dart';
import 'package:unforgettable_getaway/feature/meet_people/controller/filter_controller.dart';

Widget countrylist(bool? isColor) {
  final controller = Get.put(FilterController());

  if (!Const.countries.contains(controller.selectedCountry.value)) {
    controller.selectedCountry.value =
        Const.countries.isNotEmpty ? Const.countries.first : '';
  }

  return DropdownButtonFormField<String>(
    value: controller.selectedCountry.value,
    onChanged: (String? newValue) {
      if (newValue != null) {
        controller.updateCountry(newValue);
      }
    },
    items:
        Const.countries.toSet().map<DropdownMenuItem<String>>((String country) {
      return DropdownMenuItem<String>(
        value: country,
        child: Text(country),
      );
    }).toList(),
    isExpanded: true,
    iconSize: 30,
    icon: const Icon(Icons.arrow_drop_down),
    style: TextStyle(
      color: isColor ?? false ? Colors.white : Colors.black,
      fontSize: 18,
    ),
    dropdownColor:
        isColor ?? false ? const Color(0xff1A1110) : Colors.grey[200],
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.amber.withOpacity(.02),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: isColor ?? false
            ? const BorderSide(color: Colors.white, width: 1)
            : const BorderSide(color: Color(0xff737268)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: isColor ?? false
            ? const BorderSide(color: Colors.white, width: 1)
            : const BorderSide(color: Color(0xff737268)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: isColor ?? false
            ? const BorderSide(color: Colors.white, width: 1)
            : const BorderSide(color: Color(0xff737268)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  );
}
