import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/global_widget/custom_text_popins.dart';
import '../../../../core/utils/assetpath.dart';
import '../../controller/messeage_controllred.dart';

final SwitchController controller = Get.put(SwitchController());
class ShowCustomMenuController extends GetxController {
  RxString selectedItem1 = 'Item 1'.obs;
  void showPopupMenu1(BuildContext context){
     showMenu(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      context: context,
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width - 140,
        45.0,
        0.0,
        0.0,
      ),
      items: [
        PopupMenuItem(
          value: 'Item 1',
          child: SizedBox(
            width: 180.w,
            height: 30.h,
            child: Row(
              children: [
                Obx(() =>
                    Transform.scale(
                      scale: 0.6,
                      child: Switch(
                        value: controller.isSwitched.value,
                        onChanged: (value) {
                          controller.toggleSwitch(value);
                          Navigator.pop(context);
                        },
                      ),
                    )),
                CustomTextPopins(
                  text: "Auto Translate ",
                  fontWeight: FontWeight.w500,
                  size: 11.sp,
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
            height: 30.h,
            child: Row(
              children: [
                SizedBox(width: 12.w,),
                Image.asset(Assetpath.block),
                const SizedBox(
                  width: 10,
                ),
                CustomTextPopins(
                  text: "Block User",
                  fontWeight: FontWeight.w500,
                  size: 11.sp,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ],
      elevation: 8.0,
      constraints: const BoxConstraints(
        maxWidth: 200,
        maxHeight: 150,
      ),
    );
  }

  void toggleDropdown() {}
}
