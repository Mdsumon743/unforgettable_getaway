import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        body: Obx(() {
          return ListView.builder(
            reverse: true,
            itemCount: controller.messages.length,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    controller.messages[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(29),

          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: textController,
                  style: const TextStyle(color: Colors.white),
                  decoration:const InputDecoration(
                    hintText: "Message here...",
                    hintStyle:  TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.white),
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    controller.sendMessage(textController.text);
                    textController.clear(); // Clear after sending
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}