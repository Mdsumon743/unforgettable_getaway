import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_appbar.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_inter.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/feature/meet_people/controller/all_profile_controller.dart';
import 'package:unforgettable_getaway/feature/meet_people/controller/custom_textfeild_controller.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/widget/custom_gridview_profile.dart';

class MeetPeople extends StatelessWidget {
  const MeetPeople({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(CustomTextFieldSearchController());
    final AllProfileController allProfileController =
        Get.put(AllProfileController());

    Future<void> refreshData() async {
      allProfileController.currentPage.value = 1;
      allProfileController.allProfiles.clear();
      await allProfileController.getUserProfiles();
    }

    final ScrollController scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !allProfileController.isLoading.value) {
        allProfileController.getUserProfiles();
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Obx(
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
                      itemCount: searchController.filteredSuggestions.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:
                              Text(searchController.filteredSuggestions[index]),
                          onTap: () async {
                            searchController.updateTextController(
                                searchController.search,
                                searchController.filteredSuggestions[index]);
                            searchController.filteredSuggestions.clear();
                            allProfileController.textEditingController.text =
                                allProfileController.searchQuery;
                            allProfileController.text.value =
                                "People around '${allProfileController.searchQuery}'";
                            await allProfileController.getUserCity();
                          },
                        );
                      },
                    ),
                  ),
                )
              : RefreshIndicator(
                  color: Colors.amber,
                  onRefresh: refreshData,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: allProfileController.allProfiles.length + 1,
                    itemBuilder: (context, index) {
                      if (index == allProfileController.allProfiles.length) {
                        return Obx(() {
                          return allProfileController.isLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.amber,
                                  ),
                                )
                              : SizedBox.shrink();
                        });
                      }
                      return Padding(
                        padding: EdgeInsets.all(15.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => CustomTextIner(
                                  text: "${allProfileController.text.value} ⭐",
                                  fontWeight: FontWeight.w500,
                                  size: 16.sp,
                                )),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomGridviewProfile(),
                          ],
                        ),
                      );
                    },
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffFFDF00),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
        onPressed: () {
          Get.toNamed(AppRoute.chatList);
        },
        child: SvgPicture.asset('assets/icons/sms.svg'),
      ),
    );
  }
}
