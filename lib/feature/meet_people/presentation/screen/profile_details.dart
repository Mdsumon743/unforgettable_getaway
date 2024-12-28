import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';
import 'package:unforgettable_getaway/feature/meet_people/controller/profile_details_controller.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/widget/build_details.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/widget/custom_circle_button.dart';
import 'package:unforgettable_getaway/feature/message/controller/messeage_controllred.dart';
import 'package:unforgettable_getaway/feature/message/presentation/screen/chat/completed_premium.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
    final profileDetailsController = Get.put(ProfileDetailsController());
    final messageController = Get.put(MesseageController());

    return Scaffold(
      backgroundColor: const Color(0xff1A1110),
      body: Obx(() {
        var data = profileDetailsController.profileDetailsData.value;
        if (profileDetailsController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        } else {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: Container(
                      height: 15.h,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.r),
                              topRight: Radius.circular(24.r)),
                          color: const Color(0xff1A1110)),
                    )),
                elevation: 0,
                backgroundColor: const Color(0xff1A1110),
                leading: const SizedBox(),
                expandedHeight: 350.h,
                floating: true,
                scrolledUnderElevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1,
                  background: CachedNetworkImage(
                    imageUrl: data?.profileImage ??
                        "https://i.ibb.co.com/nrs3FjM/images.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              buildDetails(
                name: data?.fullName ?? "Unknown",
                aboutMe: data?.about ?? "Unknown",
                address:
                    "${data?.city ?? "Unknown"} ${data?.country ?? "Unknown"}",
                age: data?.age ?? "Unknown",
                flag: data?.flag ?? "Unknown",
                gellery: data?.gallery ?? [],
                height: data?.height ?? "Unknown",
                intersted: data?.interests ?? [],
                language: data?.language ?? "Unknown",
                relationshipStatus: data?.relationship ?? "Unknown",
                work: data?.work ?? "Unknown",
              )
            ],
          );
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.all(15.r),
        margin: EdgeInsets.symmetric(horizontal: 60.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            color: const Color(0xff1A1110),
            boxShadow: [
              BoxShadow(
                  color: Colors.white38.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(2, 10))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomCircleButton(
                ontap: () {
                  Get.back();
                },
                size: false,
                iconData: const Icon(
                  Icons.close,
                  size: 24,
                )),
            CustomCircleButton(
              ontap: () async {
                await preferencesHelper.init();
                String? userId = preferencesHelper.getString("userId") ?? "";
                messageController.joinChatRoom(
                    userId,
                    profileDetailsController.profileDetailsData.value?.userId ??
                        "Unknown");

                Get.to(() => CompletedPremium(
                      userid: userId,
                      reciverId: profileDetailsController
                              .profileDetailsData.value?.userId ??
                          '',
                      text: profileDetailsController
                              .profileDetailsData.value?.fullName ??
                          "Unknown",
                      img: profileDetailsController
                              .profileDetailsData.value?.profileImage ??
                          "https://i.ibb.co.com/nrs3FjM/images.png",
                    ));
              },
              size: true,
              iconData: SvgPicture.asset("assets/icons/sms.svg"),
            ),
            const CustomCircleButton(
                size: false,
                iconData: Icon(
                  Icons.favorite_sharp,
                  size: 24,
                )),
          ],
        ),
      ),
    );
  }
}
