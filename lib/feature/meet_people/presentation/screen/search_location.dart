import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/feature/meet_people/controller/custom_textfeild_controller.dart';

import '../../../../core/utils/app_colors.dart';
import '../../controller/all_profile_controller.dart';

class SearchLocation extends StatelessWidget {
  const SearchLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(CustomTextFieldSearchController());
    final allprofileController = Get.put(AllProfileController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1A1110),
        appBar: AppBar(
          toolbarHeight: 80.h,
          scrolledUnderElevation: 0,
          backgroundColor: const Color(0xff1A1110),
          title: const CustomTextFieldSearch(
            keyboardType: TextInputType.text,
            color: Colors.white,
            hintText: 'Search for people by city ',
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xff737268),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Obx(
                  () {
                    return searchController.filteredSuggestions.isNotEmpty
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.darkBrown,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount:
                                    searchController.filteredSuggestions.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: CustomTextPopins(
                                      text: searchController
                                          .filteredSuggestions[index],
                                      color: Colors.white,
                                    ),
                                    onTap: () async {
                                      searchController.updateTextController(
                                          searchController.search,
                                          searchController
                                              .filteredSuggestions[index]);

                                      allprofileController
                                              .textEditingController.text =
                                          allprofileController.searchQuery;
                                      allprofileController.text.value =
                                          "People around '${allprofileController.searchQuery}'";
                                      await allprofileController.getUserCity();
                                      Get.toNamed(AppRoute.meet);
                                      searchController.filteredSuggestions
                                          .clear();
                                    },
                                  );
                                },
                              ),
                            ),
                          )
                        : const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldSearch extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Color? color;
  final void Function()? ontap;
  final bool obscureText;
  final String? Function(String?)? validator;

  const CustomTextFieldSearch({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.textInputAction,
    this.color,
    this.fillColor,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(CustomTextFieldSearchController());
    final allprofileController = Get.put(AllProfileController());
    final FocusNode focusNode = FocusNode();

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: fillColor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xff737268), width: 1.5),
            ),
            child: TextFormField(
              focusNode: focusNode,
              textInputAction: textInputAction,
              onChanged: (query) {
                searchController.filterSuggestions(query);
                if (query.isEmpty) {
                  allprofileController.getUserProfiles();
                  allprofileController.text.value = 'Nearest people around you';
                }
              },
              controller: controller,
              onTap: ontap,
              keyboardType: keyboardType,
              obscureText: obscureText,
              validator: validator,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: color ?? const Color(0xff333329),
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: color ?? const Color(0xff333329),
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextFieldSearch2 extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Color? color;
  final Color? fillColor;
  final void Function()? ontap;
  final void Function(String)? onChanged;

  const CustomTextFieldSearch2({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.textInputAction,
    this.color,
    this.fillColor,
    this.ontap,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: fillColor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xff737268), width: 1.5),
            ),
            child: TextFormField(
              focusNode: focusNode,
              textInputAction: textInputAction,
              onChanged: (query) {
                if (onChanged != null) {
                  onChanged!(query);
                }
              },
              controller: controller,
              onTap: ontap,
              keyboardType: keyboardType,
              obscureText: obscureText,
              validator: validator,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: color ?? const Color(0xff333329),
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: color ?? const Color(0xff333329),
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
