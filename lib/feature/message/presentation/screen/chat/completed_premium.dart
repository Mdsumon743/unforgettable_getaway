// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/feature/message/presentation/widget/custom_appbar1.dart';
import '../../../../../core/global_widget/custom_text_popins.dart';
import '../../../../../core/utils/assetpath.dart';
import '../../../controller/messeage_controllred.dart';

class CompletedPremium extends StatelessWidget {
  final String img;
  final String text;
  final String? userid;
  final String? reciverId;

  const CompletedPremium({
    required this.img,
    required this.text,
    super.key,
    this.userid,
    this.reciverId,
  });

  @override
  Widget build(BuildContext context) {
    final MesseageController controller = Get.put(MesseageController());
    final TextEditingController textController = TextEditingController();
    final ScrollController scrollController = ScrollController();
    controller.messages.listen((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });
    });

    return Scaffold(
      appBar: CustomChatAppBar(
        profileImage: img,
        userName: text,
        receiverId: reciverId,
        statusText: 'Active now',
        showCallIcon: true,
      ),
      backgroundColor: const Color(0xff1A1110),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                if (controller.messages.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.error_outline_rounded,
                                color: Color(0xFFFFFDE7)),
                            SizedBox(width: 5.w),
                            CustomTextPopins(
                              textAlign: TextAlign.start,
                              text:
                                  "Your Premium upgrade was successful! You now have\nunlimited messages. Start chatting!",
                              color: const Color(0xFFFFFDE7),
                              fontWeight: FontWeight.w400,
                              size: 11.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      bool isUserMessage = controller.isUserMessage(
                          controller.messages[index]['senderId']);
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: 10.r, left: 10.r, right: 10.r),
                        child: Align(
                          alignment: isUserMessage
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.5,
                            ),
                            padding: const EdgeInsets.only(
                                top: 8, right: 10, left: 8, bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white30,
                                width: 2.w,
                              ),
                              color: isUserMessage
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              controller.messages[index]['content'],
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              softWrap: true,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.r, left: 10.r, right: 10.r),
            child: Container(
              height: 45.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white54,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Message here...',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        controller.sendMessage(
                          userid ?? "",
                          reciverId ?? "",
                          textController.text,
                        );
                        textController.clear();
                      } else {
                        debugPrint("============enter Something");
                      }
                    },
                    icon: Image.asset(
                      Assetpath.send2,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
