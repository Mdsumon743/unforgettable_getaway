import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_textfield.dart';
import 'package:unforgettable_getaway/feature/profile/controller/bio_controller.dart';

import '../../../../core/global_widget/custom_text_popins.dart';

class Bio extends StatelessWidget {
  final String? bio;
  const Bio({super.key, this.bio});

  @override
  Widget build(BuildContext context) {
    final biocontroller = Get.put(BioController());

    biocontroller.bioController.text = """$bio""";

    return Container(
      margin: EdgeInsets.all(10.r),
      padding: EdgeInsets.symmetric(horizontal: 20.r),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.02)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CustomTextPopins(
              text: "Bio",
              fontWeight: FontWeight.w600,
              size: 20.sp,
              color: Colors.white,
            ),
            Obx(() => GestureDetector(
                  onTap: () {
                    biocontroller.editBio();
                  },
                  child: biocontroller.isLoading.value
                      ? Center(
                          child: SizedBox(
                            height: 20.h,
                            width: 20.w,
                            child: const CircularProgressIndicator(
                              color: Color(0xffFFF6B2),
                            ),
                          ),
                        )
                      : CustomTextPopins(
                          text: biocontroller.bio.value == "Update"
                              ? "Update"
                              : "Edit",
                          fontWeight: FontWeight.w400,
                          size: 16.sp,
                          decoration: TextDecoration.underline,
                          color: const Color(0xffFFF6B2),
                        ),
                )),
          ]),
          SizedBox(
            height: 10.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomTextPopins(
              text: "Write a fun & punchy intro about you",
              fontWeight: FontWeight.w400,
              size: 14.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Obx(() => CustomTextField2(
                min: 4,
                enable: biocontroller.isBio.value,
                controller: biocontroller.bioController,
                colorTrue: true,
              )),
        ],
      ),
    );
  }
}
