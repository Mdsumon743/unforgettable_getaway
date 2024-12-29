import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/feature/message/controller/chatlist_controller.dart';
import 'package:unforgettable_getaway/feature/message/presentation/screen/chat/chat_list.dart';
import 'package:unforgettable_getaway/feature/message/presentation/screen/chat/empty_message.dart';

class ShowMessageScreen extends StatelessWidget {
  const ShowMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatlistController chatlistController = Get.put(ChatlistController());
    return Obx(
      () {
        if (chatlistController.allChatList.isNotEmpty) {
          return const ChatListPage();
        } else {
          return const EmptyMessage();
        }
      },
    );
  }
}
