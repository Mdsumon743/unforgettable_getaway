import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/feature/message/presentation/screen/message.dart';
import '../../../../../core/utils/assetpath.dart';
import '../../../../meet_people/presentation/screen/search_location.dart';

class ChatListPage extends StatelessWidget {
  ChatListPage({super.key});
  final List<Map<String, dynamic>> data = [
    {
      "title": "Liam Parker",
      "subtitle": "Hei   there, what’s Up ???",
      "leading": Assetpath.chat1,
      "trailing": "06:35 AM",
    },
    {
      "title": "Sophia Lee",
      "subtitle": "Have you been to any co....",
      "leading": Assetpath.chat2,
      "trailing": "12:25 PM",
    },
    {
      "title": "Ethan Taylor",
      "subtitle": "Hey! How's your day goin....",
      "leading": Assetpath.chat3,
      "trailing": "10:42 AM",
    },
    {
      "title": "Lucas Wilson",
      "subtitle": "Hi there! Just saw your p....",
      "leading": Assetpath.chat4,
      "trailing": "08:40 PM",
    },
    {
      "title": "Liam Parker",
      "subtitle": "We should swap stories....",
      "leading": Assetpath.chat5,
      "trailing": "12:25 PM",
    },
    {
      "title": "Noah Anderson",
      "subtitle": "Would you be up for a ch....",
      "leading": Assetpath.chat6,
      "trailing": "10:35 AM",
    },
    {
      "title": "Ava Martinez",
      "subtitle": "Would be cool to meet u....",
      "leading": Assetpath.chat7,
      "trailing": "11:35 AM",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.r,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextPopins(
                  text: "Chats",
                  color: const Color(0xFFFFFFFF),
                  size: 24.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextFieldSearch(
                  hintText: "Search",
                  color: Colors.white.withOpacity(0.8),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white.withOpacity(0.8),
                    weight: 18.w,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomTextPopins(
                  text: "Chat (Recent)",
                  color: Colors.white.withOpacity(0.75),
                  fontWeight: FontWeight.w400,
                  size: 14.sp,
                ),
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => MessagePage(
                                img: data[index]['leading'],
                                text: data[index]["title"],
                              ));
                        },
                        child: ListTile(
                          title: Text(
                            data[index]["title"],
                            style: GoogleFonts.poppins(
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp),
                          ),
                          subtitle: Text(
                            data[index]['subtitle'],
                            style: GoogleFonts.poppins(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          leading: Image.asset(
                            data[index]['leading'],
                            fit: BoxFit.cover,
                            height: 48.h,
                            width: 48.w,
                          ),
                          trailing: data[index]["trailing"] == "12:25 PM"
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      data[index]["trailing"],
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                    ),
                                    Container(
                                      height: 20.h,
                                      width: 20.w,
                                      margin:
                                          EdgeInsets.only(top: 5.h, left: 40.h),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFDF00),
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "2",
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF1A1110),
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  data[index]["trailing"],
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.black,
                      );
                    },
                    itemCount: data.length),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
