import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/chip_list.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_textfield.dart';
import 'package:unforgettable_getaway/core/global_widget/profile_card.dart';
import 'package:unforgettable_getaway/core/global_widget/text_and_radio_button.dart';
import 'package:unforgettable_getaway/feature/select_height.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              CustomButton(
                text: "Login",
                textColor: const Color(0XFF0D0D0C),
                onPressed: () {},
                backgroundColor: const Color(0XFFFFDF00),
                borderRadius: 40,
              ),
              // SizedBox(height: 10.h),
              // const CustomTextField(
              //   controller: null,
              //   hintText: 'Enter your email text',
              // ),
              // SizedBox(height: 10.h),
              // const TextAndRadioButton(),
              // SizedBox(height: 10.h),
              // Row(
              //   children: [
              //     const ProfileCard(),
              //     SizedBox(width: 10.h),
              //     // const ProfileCard(),
              //   ],
              // ),
              // const Expanded(child: ChipList()),
              const Expanded(child: SelectHeight())
            ],
          ),
        ),
      ),
    );
  }
}
