import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/chip_list.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/text_style.dart';
import 'package:unforgettable_getaway/feature/account_setup/controller/account_controller.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/widget/progress_bar.dart';

class InterestSelectionScreen extends StatelessWidget {
  const InterestSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountController = Get.put(AccountController());
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
                  SizedBox(height: 36.h),
                  // ListView.builder(
                  //   itemCount: accountController.favoriteList.length,
                  //   itemBuilder: (context, index){

                  // }),
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
              CustomButton(
                text: 'Next',
                textColor: AppColors.darkBrown1,
                backgroundColor: AppColors.whiteColor.withOpacity(0.5),
                onPressed: () {
                  Get.toNamed(AppRoute.home);
                },
                borderRadius: 40,
              ),
              CustomButton(
                text: 'Skip',
                textColor: AppColors.yellowColor,
                backgroundColor: AppColors.darkBrown,
                onPressed: () {},
                borderRadius: 40,
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
              onTap: () => accountController.addFavoritList("Traveling"),
              child: buildChip("🌍 Traveling")),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Movie"),
            child: buildChip("🎬 Movie"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Games"),
            child: buildChip("🎮 Games"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Traveling"),
            child: buildChip("📷 Traveling"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Booking"),
            child: buildChip("📔 Booking"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Music"),
            child: buildChip("🎵 Music"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Foodie"),
            child: buildChip("🍑 Foodie"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Campaign"),
            child: buildChip("🏕️ Campaign"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Cat"),
            child: buildChip("😸 Cat"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Dancing"),
            child: buildChip("🕺 Dancing"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Gardening"),
            child: buildChip("🏡 Gardening"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Gym"),
            child: buildChip("🤸‍♂️ Gym"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Football"),
            child: buildChip("⚽ Football"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Swimming"),
            child: buildChip("🏊 Swimming"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Tea"),
            child: buildChip("🍵 Tea"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Racing"),
            child: buildChip("🏁 Racing"),
          ),
          GestureDetector(
            onTap: () => accountController.addFavoritList("Wine"),
            child: buildChip("🍷 Wine"),
          ),
          buildChip("☕ Coffee"),
          buildChip("🫑 Vegetable"),
          buildChip("🍻 Drinks"),
          buildChip("🏏 Cricket"),
          buildChip("🎾 Tennis"),
          buildChip("🍻 Drinks"),
          buildChip("🏒 Hockey"),
          buildChip("⛳ Golf"),
          buildChip("🥊 Boxing"),
          buildChip("🥋 Karate"),
          buildChip("🚣‍♂️ Boat"),
          buildChip("🛹 Skating"),
          buildChip("🎪 Circus"),
          buildChip("🎰 Casino"),
          buildChip("🎨 Paint"),
          buildChip("🎤 Signing"),
          buildChip("🌾 Riding"),
          buildChip("🧗‍♀️ Climbing"),
          buildChip("🚣‍♂️ Boat"),
          buildChip("🚵‍♂️ Cycling"),
          buildChip("🧘 Yoga"),
        ],
      ),
    );
  }
}
