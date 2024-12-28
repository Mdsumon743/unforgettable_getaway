import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/message/presentation/widget/subscription_card1.dart';
import '../../controller/messeage_controllred.dart';
import '../widget/custom_appbar1.dart';

class MessagePage extends StatelessWidget {
  final String img;
  final String text;
  final MesseageController controller = Get.put(MesseageController());
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
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.error_outline_rounded,
                                color: Color(0xFFFF7167)),
                            SizedBox(width: 3.w),
                            CustomTextPopins(
                              textAlign: TextAlign.center,
                              text:
                                  "You've reached your limit of 1 free message. To continue \nchatting, upgrade to Premium for unlimited messages!",
                              color: const Color(0xFFFF7167),
                              fontWeight: FontWeight.w400,
                              size: 11.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  reverse: true,
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    bool isUserMessage = controller.isUserMessage("");
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
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
                            // controller.messages[index],
                            "",
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
                      onTap: () {
                        if (controller.messages.length >= 2) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: SubcriptionCard1(
                                          img: img, text: text),
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                      controller: textController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Message here...',
                        hintStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    )),
                    Obx(() {
                      return controller.isSecondMessageTriggered.value
                          ? const SizedBox()
                          : IconButton(
                              onPressed: () {
                                if (textController.text.isNotEmpty) {
                                
                                  textController.clear();
                                }
                              },
                              icon: Image.asset(
                                Assetpath.send2,
                                width: 24.w,
                                height: 24.h,
                              ),
                            );
                    }),
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
