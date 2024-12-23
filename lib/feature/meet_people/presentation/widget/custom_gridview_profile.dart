import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/feature/meet_people/controller/all_profile_controller.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/screen/profile_details.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/widget/custom_profile_view_card.dart';

class CustomGridviewProfile extends StatelessWidget {
  const CustomGridviewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final allprofileController = Get.put(AllProfileController());

    return Obx(
      () {
        if (allprofileController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        } else if (allprofileController.isLoading.value == false) {
          return GridView.builder(
            itemCount: allprofileController.allProfiles.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.5 / 0.68),
            itemBuilder: (context, index) {
              String svg = "";
              var data = allprofileController.allProfiles[index];
              if (data.isVerified == "NEW") {
                svg = "assets/images/new.svg";
              } else {
                svg = "assets/images/level.svg";
              }
              return GestureDetector(
                onTap: () {
                  Get.to(() => const ProfileDetails());
                },
                child: CustomProfileViewCard(
                  image: data.profileImage ??
                      "https://i.ibb.co.com/nrs3FjM/images.png",
                  adress: "${data.city} ${data.country} ",
                  age: data.age.toString(),
                  country: data.country,
                  distance: "3 km from you",
                  level: svg,
                  love: "assets/images/unlove.svg",
                  name: data.fullName,
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CustomTextPopins(text: "No Data Foound"),
          );
        }
      },
    );
  }
}
