import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/profile/controller/bio_controller.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/screen/favorite_list.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/screen/favorites_me.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/widget/about.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/widget/bio.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/widget/favorited.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/widget/photo_gridview.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/widget/subcription_card.dart';
import 'package:unforgettable_getaway/feature/profile/presentation/widget/verification.dart';
import '../../../../core/chip_list.dart';
import '../../../meet_people/controller/all_profile_controller.dart';
import '../../../payment/presentation/screen/subcription_plan.dart';
import '../../controller/profile_controller.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final profilecontroller = Get.put(ProfileController());
    final BioController bioController = Get.put(BioController());
    final allprofileController = Get.find<AllProfileController>();

    return Scaffold(
        backgroundColor: const Color(0xff1A1110),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: const Color(0xff1A1110),
          centerTitle: true,
          title: CustomTextPopins(
            text: "Profile",
            fontWeight: FontWeight.w500,
            size: 24.sp,
            color: Colors.white,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showLogoutMenu(context);
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ))
          ],
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: Obx(
          () => profilecontroller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellowColor,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.r),
                    child: Center(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 100.h,
                                width: 120.w,
                              ),
                              CircleAvatar(
                                  radius: 60.h,
                                  backgroundImage: NetworkImage(profilecontroller
                                          .userData.value?.profileImage ??
                                      "https://i.ibb.co.com/nrs3FjM/images.png")),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    profilecontroller.updateData();
                                    Get.toNamed(AppRoute.profileEdit);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(3.r),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff333329)),
                                    child: Center(
                                      child: Image.asset(Assetpath.edit),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomTextPopins(
                                text: profilecontroller
                                        .userData.value?.fullName ??
                                    "Unknown",
                                fontWeight: FontWeight.w600,
                                size: 26.sp,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              SvgPicture.asset(Assetpath.verified)
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              fovoritedMe(
                                  allprofileController.fvMe.value.toString(),
                                  "Favorited Me", () {
                                Get.to(() => const FavoritesMe());
                              }),
                              SizedBox(
                                width: 30.w,
                              ),
                              fovoritedMe(
                                  allprofileController.fvList.value.toString(),
                                  "Favorite List", () {
                                Get.to(() => const FavoritesList());
                              }),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          const Divider(
                            height: 0.5,
                            thickness: 0.5,
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.to(() => const SubscriptionPlan());
                              },
                              child: const SubcriptionCard()),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextPopins(
                                    text: "Photo",
                                    fontWeight: FontWeight.w600,
                                    size: 20.sp,
                                    color: Colors.white,
                                  ),
                                  CustomTextPopins(
                                    text: "Pick some taht show the real you",
                                    fontWeight: FontWeight.w400,
                                    size: 14.sp,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.r, vertical: 20.r),
                            child: PhotoGridview(
                                ontap: () {
                                  profilecontroller.showImagePickerDialog(
                                      context, false);
                                },
                                gallery:
                                    profilecontroller.userData.value?.gallery ??
                                        [],
                                main: profilecontroller
                                        .userData.value?.profileImage ??
                                    ""),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Verification(),
                          SizedBox(
                            height: 15.h,
                          ),
                          Bio(
                            bio: profilecontroller.userData.value?.about ??
                                "Unknown",
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.r),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextPopins(
                                    text: "Interest",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    size: 18.sp,
                                  ),
                                  Obx(() => GestureDetector(
                                        onTap: () {
                                          bioController.editIntersted();
                                        },
                                        child: CustomTextPopins(
                                          text: bioController.interest.value ==
                                                  "Update"
                                              ? "Update"
                                              : "Edit",
                                          fontWeight: FontWeight.w400,
                                          size: 16.sp,
                                          decoration: TextDecoration.underline,
                                          color: const Color(0xffFFF6B2),
                                        ),
                                      )),
                                ]),
                          ),
                          Obx(() => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.r),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  itemCount: bioController.favoriteList.length,
                                  itemBuilder: (context, index) {
                                    var favoriteListItem =
                                        bioController.favoriteList[index];
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Wrap(
                                        spacing: 10.0,
                                        runSpacing: -5.0,
                                        runAlignment: WrapAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              onTap: () {
                                                bioController
                                                    .deleteFavoriteItemByIndex(
                                                        index);
                                              },
                                              child: buildChip(
                                                  favoriteListItem ?? "",
                                                  size: 10)),
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
                              )),
                          SizedBox(
                            height: 20.h,
                          ),
                          Obx(() => bioController.isinterest.value
                              ? interestList2(bioController)
                              : const SizedBox()),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.r),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: CustomTextPopins(
                                text: "About you",
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                size: 18.sp,
                              ),
                            ),
                          ),
                          aboutMe(
                              "Work",
                              profilecontroller.userData.value?.work ??
                                  "Unknown",
                              Assetpath.work),
                          aboutMe(
                              "Gender",
                              profilecontroller.userData.value?.gender ??
                                  "Unknown",
                              Assetpath.gender),
                          aboutMe(
                              "Location",
                              "${profilecontroller.userData.value?.city} ${profilecontroller.userData.value?.country}",
                              Assetpath.onLocation),
                          aboutMe(
                              "Language",
                              profilecontroller.userData.value?.language ??
                                  "Unknown",
                              Assetpath.lang),
                          aboutMe(
                              "Relationship Status",
                              profilecontroller.userData.value?.relationship ??
                                  "Unknown",
                              Assetpath.relation),
                          aboutMe(
                              "Age",
                              profilecontroller.userData.value?.age ??
                                  "Unknown",
                              Assetpath.age),
                          aboutMe(
                              "Height",
                              profilecontroller.userData.value?.height ??
                                  "Unknown",
                              Assetpath.height),
                        ],
                      ),
                    ),
                  ),
                ),
        ));
  }
}

void showLogoutMenu(BuildContext context) async {
  final ProfileController profileController = Get.put(ProfileController());
  // ignore: unused_local_variable
  final result = await showMenu(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
    context: context,
    position: RelativeRect.fromLTRB(
      MediaQuery.of(context).size.width - 150,
      90.0,
      0.0,
      0.0,
    ),
    items: [
      PopupMenuItem(
        onTap: () {
          profileController.logout();
        },
        value: 'Item 1',
        child: SizedBox(
          width: 100.w,
          height: 40.h,
          child: Row(
            children: [
              Image.asset(
                Assetpath.logout,
                height: 24.h,
                width: 24.w,
              ),
              const SizedBox(
                width: 10,
              ),
              CustomTextPopins(
                text: "Logout",
                fontWeight: FontWeight.w500,
                size: 16.sp,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    ],
    elevation: 8.0,
    constraints: const BoxConstraints(
      maxWidth: 200,
      maxHeight: 200,
    ),
  );
}

interestList2(BioController accountController) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.r),
    child: Align(
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
    ),
  );
}
