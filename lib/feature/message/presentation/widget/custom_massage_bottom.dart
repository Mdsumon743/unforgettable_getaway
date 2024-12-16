import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../meet_people/controller/custom_textfeild_controller.dart';

class CustomMassageBottom extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  const CustomMassageBottom({
    super.key,
    this.hintText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xff737268), width: 1.5),
            ),
            child: TextFormField(
              style:const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                ),
                suffixIcon: suffixIcon,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
