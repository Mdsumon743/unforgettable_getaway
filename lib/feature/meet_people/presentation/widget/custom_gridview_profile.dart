import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/feature/meet_people/controller/all_profile_controller.dart';
import 'package:unforgettable_getaway/feature/meet_people/controller/profile_details_controller.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/widget/custom_profile_view_card.dart';

class CustomGridviewProfile extends StatelessWidget {
  const CustomGridviewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final allprofileController = Get.find<AllProfileController>();
    final profileDetailsController = Get.put(ProfileDetailsController());

    return Obx(
      () {
        if (allprofileController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        } else if (allprofileController.allProfiles.isEmpty) {
          return const Center(
            child: CustomTextPopins(text: "No Profile Found"),
          );
        } else {
          return ListView.builder(
            itemCount: allprofileController.allProfiles.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            itemBuilder: (context, index) {
              var data = allprofileController.allProfiles[index];
              String svg = data.isVerified == "NEW"
                  ? "assets/images/new.svg"
                  : "assets/images/level.svg";

              String love = data.isFavorite == true
                  ? "assets/images/love.svg"
                  : "assets/images/unlove.svg";

              return GestureDetector(
                onTap: () {
                  profileDetailsController
                      .getSignleProfileDetails(data.userId.toString());
                  Get.toNamed(AppRoute.profileDetils);
                },
                child: CustomProfileViewCard(
                  image: data.profileImage ??
                      "https://i.ibb.co.com/nrs3FjM/images.png",
                  adress: "${data.city} ${data.country}",
                  age: data.age.toString(),
                  country: data.flag ?? "🇧🇩",
                  distance: "3 km from you",
                  level: svg,
                  love: love,
                  userId: data.userId.toString(),
                  name: data.fullName,
                ),
              );
            },
          );
        }
      },
    );
  }
}
