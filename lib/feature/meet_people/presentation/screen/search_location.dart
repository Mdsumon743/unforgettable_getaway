import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/feature/meet_people/controller/custom_textfeild_controller.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/screen/meet_people.dart';

class SearchLocation extends StatelessWidget {
  const SearchLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(CustomTextFieldSearchController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                const CustomTextFieldSearch(
                  keyboardType: TextInputType.text,
                  hintText: 'Search for people by city ',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xff737268),
                  ),
                ),
                Obx(
                  () {
                    return searchController.filteredSuggestions.isNotEmpty
                        ? Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                    title: Text(searchController
                                        .filteredSuggestions[index]),
                                    onTap: () {
                                      searchController.updateTextController(
                                          searchController.search,
                                          searchController
                                              .filteredSuggestions[index]);
                                      searchController.filteredSuggestions
                                          .clear();
                                      Get.to(() => const MeetPeople());
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
              textInputAction: textInputAction,
              onChanged: (query) => searchController.filterSuggestions(query),
              controller: controller,
              onTap: ontap,
              keyboardType: keyboardType,
              obscureText: obscureText,
              validator: validator,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: color ?? const Color(0xff333329),
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: hintText,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 16,
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
