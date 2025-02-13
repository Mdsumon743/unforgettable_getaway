// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_textfield.dart';
import 'package:unforgettable_getaway/feature/profile/controller/profile_controller.dart';

import '../../../../core/global_widget/custom_text_popins.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    generateHeightList();

    final ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xff1A1110),
        centerTitle: true,
        title: CustomTextPopins(
          text: "Edit Profile",
          fontWeight: FontWeight.w500,
          size: 24.sp,
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
      backgroundColor: const Color(0xff1A1110),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Center(
              child: Column(
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
                  SizedBox(
                    height: 30.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextPopins(
                        text: "Basic",
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextPopins(
                        text: "Username",
                        fontWeight: FontWeight.w400,
                        size: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomTextField2(
                        controller: profileController.userName,
                        hintText: profileController.userName.text,
                        colorTrue: true,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextPopins(
                        text: "Full name*",
                        fontWeight: FontWeight.w400,
                        size: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomTextField2(
                        hintText: profileController.fullName.text,
                        controller: profileController.fullName,
                        colorTrue: true,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // CustomTextPopins(
                      //   text: "Country*",
                      //   fontWeight: FontWeight.w400,
                      //   size: 14.sp,
                      //   color: Colors.white.withOpacity(0.9),
                      // ),
                      // SizedBox(
                      //   height: 5.h,
                      // ),
                      // countrylist(true),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      CustomTextPopins(
                        text: "Language*",
                        fontWeight: FontWeight.w400,
                        size: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomTextField2(
                        validator: (value) {
                          if (value!.length > 15) {
                            return 'Enter a valid language';
                          }
                          return null;
                        },
                        hintText: profileController.language.text,
                        controller: profileController.language,
                        colorTrue: true,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextPopins(
                        text: "Gender*",
                        fontWeight: FontWeight.w400,
                        size: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Obx(() => CustomTextField2(
                          enable: false,
                          colorTrue: true,
                          hintText: profileController.gender.value,
                          controller: profileController.genderText,
                          suffix: PopupMenuButton<String>(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                            onSelected: (valueindex) {
                              profileController.updateGender(valueindex);
                            },
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                onTap: () {},
                                value: 'MALE',
                                child: const Text('Male'),
                              ),
                              const PopupMenuItem(
                                value: 'FEMALE',
                                child: Text('Female'),
                              ),
                            ],
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.r),
                              child: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ),
                          ))),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextPopins(
                        text: "Age*",
                        fontWeight: FontWeight.w400,
                        size: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomTextField2(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.length > 2) {
                            return 'Enter a valid age';
                          }
                          return null;
                        },
                        colorTrue: true,
                        hintText: profileController.age.text,
                        controller: profileController.age,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextPopins(
                        text: "Height*",
                        fontWeight: FontWeight.w400,
                        size: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Obx(() => CustomTextField2(
                            controller: profileController.heightText,
                            enable: false,
                            hintText: profileController.height.value,
                            suffix: PopupMenuButton<String>(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r)),
                              onSelected: (valueindex) {
                                profileController.updateHeight(valueindex);
                              },
                              itemBuilder: (BuildContext context) =>
                                  height.map((String value) {
                                return PopupMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.r),
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextPopins(
                        text: "Relation Status",
                        fontWeight: FontWeight.w400,
                        size: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Obx(
                        () => CustomTextField2(
                          controller: profileController.statusText,
                          enable: false,
                          hintText: profileController.status.value,
                          suffix: PopupMenuButton<String>(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                            onSelected: (valueindex) {
                              profileController.updatestaus(valueindex);
                            },
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'SINGLE',
                                child: Text('Single'),
                              ),
                              const PopupMenuItem(
                                value: 'MARRIED',
                                child: Text('Married'),
                              ),
                              const PopupMenuItem(
                                value: 'INRELATIONSHIP',
                                child: Text('in a Relationship'),
                              ),
                              const PopupMenuItem(
                                value: 'COMPLICATED',
                                child: Text('It’s Complicated'),
                              ),
                            ],
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomTextPopins(
                        max: 1,
                        text: "Work",
                        fontWeight: FontWeight.w400,
                        size: 14.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      CustomTextField2(
                        validator: (value) {
                          if (value!.length > 15) {
                            return 'Enter a valid work';
                          }
                          return null;
                        },
                        hintText: profileController.work.text,
                        colorTrue: true,
                        controller: profileController.work,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(() => profileController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                        )
                      : CustomButton(
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              profileController.saveUserInformation();
                              profileController.submitUserData(
                                  profileImage:
                                      profileController.avatarFile.value);
                            }
                          },
                          text: "Update Profile",
                          borderRadius: 30.r,
                          backgroundColor: const Color(0xffFFDF00),
                          textColor: Colors.black,
                        ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final List<String> height = [];

void generateHeightList() {
  for (int feet = 4; feet <= 6; feet++) {
    for (int inches = 0; inches < 12; inches++) {
      height.add('$feet"$inches');
    }
  }
}
