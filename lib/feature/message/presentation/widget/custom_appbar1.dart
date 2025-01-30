import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/feature/message/controller/messeage_controllred.dart';
import 'package:unforgettable_getaway/feature/message/presentation/screen/chat/zego_call.dart';
import 'package:unforgettable_getaway/feature/message/presentation/widget/show_custom_menu.dart';
import '../../../../core/utils/assetpath.dart';
import '../../controller/audio_video_controller.dart';

class CustomChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String profileImage;
  final String userName;
  final String statusText;
  final String? receiverId;
  final bool showCallIcon;

  CustomChatAppBar({
    super.key,
    required this.profileImage,
    required this.userName,
    required this.statusText,
    this.receiverId,
    this.showCallIcon = false,
  });

  final ShowCustomMenuController controller =
      Get.put(ShowCustomMenuController());
  final MesseageController messageController = Get.put(MesseageController());
  final CallController callController = Get.put(CallController());

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff1A1110),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CircleAvatar(
            radius: 20.r,
            backgroundImage: CachedNetworkImageProvider(profileImage),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        if (showCallIcon)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Get.to(
                      () => VideoCall(name: userName, id: receiverId ?? '122'));
                },
                icon: Image.asset(Assetpath.video),
              ),
              SizedBox(height: 5.h),
              IconButton(
                onPressed: () {
                  Get.to(() => AudioCall(
                        name: userName,
                        id: receiverId ?? '122',
                      ));
                },
                icon: Image.asset(Assetpath.audio),
              ),
            ],
          ),
        SizedBox(
          width: 10.w,
        ),
        GestureDetector(
          onTap: () {
            controller.showPopupMenu1(context);
          },
          child: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
