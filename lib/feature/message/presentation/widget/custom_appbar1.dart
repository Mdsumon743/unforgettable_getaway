import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

class CustomChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String profileImage;
  final String userName;
  final String statusText;
  final bool showCallIcon;

  const CustomChatAppBar({
    Key? key,
    required this.profileImage,
    required this.userName,
    required this.statusText,
    this.showCallIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff1A1110),
      elevation: 0,
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
            backgroundImage: AssetImage(profileImage),
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
        PopupMenuButton(
          icon:const Icon(Icons.more_vert_outlined, color: Colors.white),
            offset: const Offset(0, 50),
            color: const Color(0xffFFFDF2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
    ),
          onSelected: (value){
        },itemBuilder: (context){
          return[
            PopupMenuItem(
              value: 0,
              child: Row(
                children: [
                  Image.asset(Assetpath.popup1),
                  const SizedBox(width: 10),
                  Text(
                    "Auto Translate",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  Image.asset(Assetpath.popup2),
                  const SizedBox(width: 10),
                  Text(
                    "Block User",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
            ),
        if(showCallIcon)
          IconButton(
              onPressed: (){
              },
              icon: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.call))),
        if (showCallIcon)
          IconButton(
            icon: Icon(Icons.call, color: Colors.white, size: 24.sp),
            onPressed: () {
            },
          ),
      ],
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
