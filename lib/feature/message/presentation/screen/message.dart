import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import '../../controller/messeage_controllred.dart';
import '../widget/custom_appbar1.dart';

class MessagePage extends StatelessWidget {
  final String img;
  final String text;

  final MessageController controller = Get.put(MessageController());
  MessagePage({
    super.key,
    required this.img,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1A1110),
        appBar: CustomChatAppBar(
          profileImage: img,
          userName: text,
          statusText: 'Active now',
          showCallIcon: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isSecondMessageTriggered.value) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                          const Icon(Icons.error_outline_rounded,color: Color(0xFFFF7167)),
                           SizedBox(width: 3.w),
                           Text(
                          "You've reached your limit of 1 free message. To continue",
                             style: GoogleFonts.poppins(
                               color: const Color(0xFFFF7167),
                               fontSize: 11.sp,
                               fontWeight: FontWeight.w400,
                             ),
                        ),
                         ],
                        ),
                        Text("   chatting, upgrade to Premium for unlimited messages!",
                          style: GoogleFonts.poppins(
                            color: const Color(0xFFFF7167),
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                          )),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  reverse: true,
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
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
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            controller.messages[index],
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
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              child: Container(
                height: 60,
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
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (textController.text.isNotEmpty) {
                          controller.sendMessage(textController.text);
                          textController.clear();
                        }
                      },
                      icon: Image.asset(
                        Assetpath.send1,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
