import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/feature/meet_people/controller/all_profile_controller.dart';
import 'package:unforgettable_getaway/feature/message/presentation/screen/chat/completed_premium.dart';
import 'package:unforgettable_getaway/feature/message/presentation/screen/message.dart';

class ShowMessageScreen2 extends StatelessWidget {
  final String img;
  final String text;
  final String? reciverId;
  final String? userid;
  const ShowMessageScreen2(
      {super.key,
      required this.img,
      required this.text,
      this.reciverId,
      this.userid});

  @override
  Widget build(BuildContext context) {
    AllProfileController allProfileController = Get.put(AllProfileController());
    return Obx(
      () {
        if (allProfileController.subscribe.value) {
          return CompletedPremium(
            img: img,
            text: text,
            reciverId: reciverId,
            userid: userid,
          );
        } else {
          return MessagePage(
              img: img, text: text, reciverId: reciverId, userid: userid);
        }
      },
    );
  }
}
