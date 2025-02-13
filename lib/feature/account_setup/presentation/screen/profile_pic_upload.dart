import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';

import '../../../../core/global_widget/custom_button.dart';
import '../../../profile/controller/profile_controller.dart';

class ProfilePicUpload extends StatelessWidget {
  const ProfilePicUpload({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: const Color(0xff1A1110),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xff1A1110),
        centerTitle: true,
        title: CustomTextPopins(
          text: "Upload Profile Picture",
          fontWeight: FontWeight.w500,
          size: 20.sp,
          color: Colors.white,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0.r),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Obx(() => CircleAvatar(
                        radius: 60.h,
                        backgroundImage: profileController.avatarFile.value !=
                                null
                            ? FileImage(profileController.avatarFile.value!)
                            : CachedNetworkImageProvider(profileController
                                        .userData.value?.profileImage ??
                                    "https://i.ibb.co.com/nrs3FjM/images.png")
                                as ImageProvider,
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      profileController.showImagePickerDialog(context, true);
                    },
                    child: Container(
                      height: 40.h,
                      width: 180.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(
                              color: Colors.white.withOpacity(.1), width: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          CustomTextPopins(
                            text: "Add Photo",
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            size: 16.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() => profileController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    )
                  : CustomButton(
                      onPressed: () {
                      
                        profileController.submitUserData(
                            profileImage: profileController.avatarFile.value);
                      },
                      text: "Upload Profile",
                      borderRadius: 30.r,
                      backgroundColor: const Color(0xffFFDF00),
                      textColor: Colors.black,
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
