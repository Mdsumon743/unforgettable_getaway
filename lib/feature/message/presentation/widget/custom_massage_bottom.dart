import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomMassageBottom extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  const CustomMassageBottom({
    super.key,
   required this.hintText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: const Color(0xff737268), width: 1.5),
          ),
          child: TextFormField(
            style:const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 15, top: 10, bottom: 15),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.75),
              ),
              suffixIcon: Obx((){
                return Container(
                  child: Icon(Icons.add),
                );
              }),
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
          ),
        ),
      ],
    );
  }
}
