import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/chip_list.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
import 'package:unforgettable_getaway/feature/account_setup/controller/account_controller.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/widget/progress_bar.dart';
import 'package:unforgettable_getaway/feature/profile/controller/profile_controller.dart';

class InterestSelectionScreen extends StatelessWidget {
  const InterestSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountController = Get.put(AccountController());
    final profileController = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: AppColors.darkBrown,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(top: 60.h, left: 16.w, right: 16.w, bottom: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProgressBar(width: 1),
                  SizedBox(height: 26.h),
                  Text(
                    'Pick 5 Things That Spark Your Interest',
                    style: textStyle(
                      30.sp,
                      AppColors.whiteColor,
                      FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Passionate about adventure or love exploring new places? Add your interests to your profile and connect with people who share your vibe',
                    style: textStyle(
                      16.sp,
                      const Color(0xFFFFFFFF).withOpacity(0.8),
                      FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Obx(
                    () => GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: accountController.favoriteList.length,
                      itemBuilder: (context, index) {
                        var favoriteListItem =
                            accountController.favoriteList[index];
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 10.0,
                            runSpacing: -5.0,
                            runAlignment: WrapAlignment.spaceAround,
                            children: [
                              InkWell(
                                  borderRadius: BorderRadius.circular(30),
                                  onLongPress: () {
                                    accountController
                                        .deleteFavoriteItemByIndex(index);
                                  },
                                  child: buildChip(favoriteListItem, size: 10)),
                            ],
                          ),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 3.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'You might like...',
                    style: textStyle(
                      20.sp,
                      AppColors.whiteColor.withOpacity(0.95),
                      FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  interestList(accountController),
                ],
              ),
              SizedBox(
                height: 100.h,
              ),
              Obx(
                () => accountController.favoriteList.length >= 5 &&
                        accountController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      )
                    : CustomButton(
                        text: 'Next',
                        textColor: accountController.favoriteList.length >= 5
                            ? const Color(0XFF0D0D0C)
                            : AppColors.darkBrown1,
                        backgroundColor:
                            accountController.favoriteList.length >= 5
                                ? AppColors.yellowColor
                                : AppColors.whiteColor.withOpacity(0.5),
                        onPressed: () {
                          if (accountController.favoriteList.length >= 5) {
                             profileController.getUserProfiles();
                            accountController.saveUserInformation();
                            accountController.submitUserData();

                          }
                        },
                        borderRadius: 40,
                      ),
              ),
              CustomButton(
                text: 'Skip',
                textColor: AppColors.yellowColor,
                backgroundColor: AppColors.darkBrown,
                onPressed: () {
                  profileController.getUserProfiles();
                  accountController.saveUserInformation();
                  accountController.submitUserData();
                },
                borderRadius: 40.r,
              )
            ],
          ),
        ),
      ),
    );
  }

  interestList(AccountController accountController) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 6.0,
        runSpacing: -5.0,
        runAlignment: WrapAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => accountController.addFavoritList("🌍 Traveling"),
            child: buildChip("🌍 Traveling"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("🎬 Movie"),
            child: buildChip("🎬 Movie"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("🎮 Games"),
            child: buildChip("🎮 Games"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Traveling"),
            child: buildChip("📷 Traveling"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("📔 Booking"),
            child: buildChip("📔 Booking"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("🎵 Music"),
            child: buildChip("🎵 Music"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("🍑 Foodie"),
            child: buildChip("🍑 Foodie"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("🏕️ Campaign"),
            child: buildChip("🏕️ Campaign"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("😸 Cat"),
            child: buildChip("😸 Cat"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("🕺 Dancing"),
            child: buildChip("🕺 Dancing"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("🏡 Gardening"),
            child: buildChip("🏡 Gardening"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("🤸‍♂️ Gym"),
            child: buildChip("🤸‍♂️ Gym"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("⚽ Football"),
            child: buildChip("⚽ Football"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("🏊 Swimming"),
            child: buildChip("🏊 Swimming"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Tea"),
            child: buildChip("🍵 Tea"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("🏁 Racing"),
            child: buildChip("🏁 Racing"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("🍷 Wine"),
            child: buildChip("🍷 Wine"),
          ),
          GestureDetector(
              onTap: () => accountController.addFavoritList("☕ Coffee"),
              child: buildChip("☕ Coffee")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🫑 Vegetable"),
              child: buildChip("🫑 Vegetable")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🍻 Drinks"),
              child: buildChip("🍻 Drinks")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🏏 Cricket"),
              child: buildChip("🏏 Cricket")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🎾 Tennis"),
              child: buildChip("🎾 Tennis")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🍻 Drinks"),
              child: buildChip("🍻 Drinks")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🏒 Hockey"),
              child: buildChip("🏒 Hockey")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("⛳ Golf"),
              child: buildChip("⛳ Golf")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🥊 Boxing"),
              child: buildChip("🥊 Boxing")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🥋 Karate"),
              child: buildChip("🥋 Karate")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🚣‍♂️ Boat"),
              child: buildChip("🚣‍♂️ Boat")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🛹 Skating"),
              child: buildChip("🛹 Skating")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🎪 Circus"),
              child: buildChip("🎪 Circus")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🎰 Casino"),
              child: buildChip("🎰 Casino")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🎨 Paint"),
              child: buildChip("🎨 Paint")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🎤 Signing"),
              child: buildChip("🎤 Signing")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🌾 Riding"),
              child: buildChip("🌾 Riding")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🧗‍♀️ Climbing"),
              child: buildChip("🧗‍♀️ Climbing")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🚣‍♂️ Boat"),
              child: buildChip("🚣‍♂️ Boat")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🚵‍♂️ Cycling"),
              child: buildChip("🚵‍♂️ Cycling")),
          GestureDetector(
              onTap: () => accountController.addFavoritList("🧘 Yoga"),
              child: buildChip("🧘 Yoga")),
        ],
      ),
    );
  }
}
