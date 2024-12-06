import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

class DropdownMenuController extends GetxController {
  RxString selectedItem = 'Item 1'.obs;

  void showPopupMenu(BuildContext context) async {
    // ignore: unused_local_variable
    final result = await showMenu(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      context: context,
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width - 150,
        90.0,
        0.0,
        0.0,
      ),
      items: [
        PopupMenuItem(
          value: 'Item 1',
          child: Container(
            color: const Color(0xffFFDF00),
            width: 160.w,
            height: 50.h,
            child: Row(
              children: [
                Image.asset(Assetpath.toly),
                const SizedBox(
                  width: 10,
                ),
                CustomTextPopins(
                  text: "Book Tour",
                  fontWeight: FontWeight.w500,
                  size: 16.sp,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
        PopupMenuItem(
          value: 'Item 2',
          child: SizedBox(
            width: 160.w,
            height: 50.h,
            child: Row(
              children: [
                Image.asset(Assetpath.people),
                const SizedBox(
                  width: 10,
                ),
                CustomTextPopins(
                  text: "Meet People",
                  fontWeight: FontWeight.w500,
                  size: 16.sp,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
        PopupMenuItem(
          value: 'Item 3',
          child: SizedBox(
            width: 160.w,
            height: 50.h,
            child: Row(
              children: [
                Image.asset(Assetpath.profile),
                const SizedBox(
                  width: 10,
                ),
                CustomTextPopins(
                  text: "Profile",
                  fontWeight: FontWeight.w500,
                  size: 16.sp,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ],
      elevation: 8.0,
      constraints: const BoxConstraints(
        maxWidth: 200, // Set maximum width for the popup
        maxHeight: 200, // Set maximum height for the popup
      ),
    );
  }
}
