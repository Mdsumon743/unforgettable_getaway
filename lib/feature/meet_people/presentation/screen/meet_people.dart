import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_appbar.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_inter.dart';
import 'package:unforgettable_getaway/feature/meet_people/controller/custom_textfeild_controller.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/widget/custom_gridview_profile.dart';
import 'package:unforgettable_getaway/feature/notification/presentation/screen/chat_list.dart';
import 'package:unforgettable_getaway/feature/notification/presentation/screen/search_list.dart';

class MeetPeople extends StatelessWidget {
  const MeetPeople({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(CustomTextFieldSearchController());
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
                          onTap: () {
                            searchController.updateTextController(
                                searchController.search,
                                searchController.filteredSuggestions[index]);
                            Get.to(() => const MeetPeople());
                          },
                        );
                      },
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15.r),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextIner(
                            text: "Nearest people around you ⭐",
                            fontWeight: FontWeight.w500,
                            size: 16.sp,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const CustomGridviewProfile()
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xffFFDF00),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
        onPressed: () {
          Get.to(()=> const SearchListPage());
        },
        child: SvgPicture.asset('assets/icons/sms.svg'),
      ),
    );
  }
}
