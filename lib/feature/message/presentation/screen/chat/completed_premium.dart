import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/feature/message/presentation/widget/custom_appbar1.dart';
import '../../../../../core/utils/assetpath.dart';
import '../../../controller/messeage_controllred.dart';

class CompletedPremium extends StatelessWidget {
  final String img;
  final String text;
  final MessageController1 controller1 = Get.put(MessageController1());
  final TextEditingController textController = TextEditingController();

  CompletedPremium({
     required this.img,
    required this.text,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomChatAppBar(
        profileImage: img,
        userName: text,
        statusText: 'Active now',
        showCallIcon: true,
      ),
      backgroundColor: const Color(0xff1A1110),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                reverse: true,
                itemCount: controller1.messages1.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery
                              .of(context)
                              .size
                              .width * 0.5,
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
                          controller1.messages1[index],
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
            },
            ),
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
                  IconButton(
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        controller1.sendMessage1(textController.text);
                        textController.clear();
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
          ),
        ],
      ),
    );
  }
}
