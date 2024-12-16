import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/feature/message/presentation/widget/custom_massage_bottom.dart';
import '../widget/custom_appbar1.dart';

class MessagePage extends StatelessWidget {
  final String img;
  final String text;
  const MessagePage({
    super.key,
    required this.img,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width;
    double width = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomChatAppBar(
        profileImage: img,
        userName: text,
        statusText: 'Active now',
        showCallIcon: false,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xff1A1110),
        child:const Center(
          child: CustomMassageBottom(
            hintText: 'Message here....',
            suffixIcon: Icon(Icons.send,color: Colors.white,),
          ),
        ),
      ),
    );
  }
}
