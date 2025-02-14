// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/feature/message/controller/chatlist_controller.dart';
import 'package:unforgettable_getaway/feature/message/controller/messeage_controllred.dart';
import 'package:unforgettable_getaway/feature/message/presentation/screen/chat/completed_premium.dart';
import '../../../../meet_people/presentation/screen/search_location.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatlistController chatlistController = Get.put(ChatlistController());
    final MesseageController messeageController = Get.put(MesseageController());
    String extractTime(String dateTimeString) {
      try {
        final dateTime = DateTime.parse(dateTimeString);
        // Format only the time as a string
        return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
      } catch (e) {
        return "";
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1A1110),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color(0xff1A1110),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Obx(() => Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        var chatData = chatlistController.allChatList[index];
                        var time =
                            extractTime((chatData.lastMessageDate.toString()));
                        return GestureDetector(
                          onTap: () {
                            messeageController.joinChatRoom(
                                messeageController.userid,
                                chatData.user.userId);
                            Get.to(() => CompletedPremium(
                                  img: chatData.user.profileImage ??
                                      "https://i.ibb.co.com/nrs3FjM/images.png",
                                  text: chatData.user.fullName ?? "Unknown",
                                  userid: messeageController.userid,
                                  reciverId: chatData.user.userId,
                                ));
                          },
                          child: ListTile(
                              title: Text(
                                chatData.user.fullName ?? "Unknown",
                                style: GoogleFonts.poppins(
                                    color: const Color(0xFFFFFFFF),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp),
                              ),
                              subtitle: Text(
                                chatData.lastMessage ?? "",
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              leading: CircleAvatar(
                                radius: 25.r,
                                backgroundImage: CachedNetworkImageProvider(
                                  chatData.user.profileImage ??
                                      "https://i.ibb.co.com/nrs3FjM/images.png",
                                ),
                              ),
                              trailing: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    time,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                  ),
                                  // Flexible(
                                  //   child: Container(
                                  //     height: 15.h,
                                  //     width: 15.w,
                                  //     decoration: BoxDecoration(
                                  //       color: const Color(0xFFFFDF00),
                                  //       borderRadius: BorderRadius.circular(12.r),
                                  //     ),
                                  //     alignment: Alignment.center,
                                  //     child: Text(
                                  //       "2",
                                  //       style: GoogleFonts.poppins(
                                  //         color: const Color(0xFF1A1110),
                                  //         fontSize: 12.sp,
                                  //         fontWeight: FontWeight.w400,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              )),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 5.h,
                        );
                      },
                      itemCount: chatlistController.allChatList.length),
                )),
          ],
        ),
      ),
    );
  }
}
