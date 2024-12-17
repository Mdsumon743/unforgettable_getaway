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
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,),
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
                ),
              );
            },
          );
        }),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            height: 60,
            width: 420,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white54,
                width: 2,
              ),
            ),
            child: FloatingActionButton(
              onPressed: () {
              },
              backgroundColor: Colors.transparent,
              elevation: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      style: const TextStyle(color: Colors.white),
                      decoration:const InputDecoration(
                        hintText: 'Message here...',
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      ),
                    ),
                  ),
                  // Send Icon
                  IconButton(onPressed: (){
                    if(textController.text.isNotEmpty){
                      controller.sendMessage(textController.text);
                      textController.clear();
                    }
                  }, icon: const Icon(Icons.send,color: Colors.white,))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
