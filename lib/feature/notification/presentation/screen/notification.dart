// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/notification/controller/notification_controller.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final notificationController = Get.put(NotificationController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            weight: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Notification",
          style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFFFFFFF)),
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Obx(() => ListTile(
                leading: CircleAvatar(
                  radius: 25.r,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: Image.asset(
                    Assetpath.noti2,
                    fit: BoxFit.cover,
                    height: 28.h,
                    width: 28.w,
                    color: const Color(0xFFFFF9CC),
                  ),
                ),
                title: Text(
                  notificationController.notificationList[index].body,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                      fontSize:  14.sp,
                      fontWeight:  FontWeight.w400,
                      color: Colors.white),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notificationController.notificationList[index].createdAt.toIso8601String()
                         ,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14.sp,
                      ),
                    ),
                    // Text(
                    //   notificationController.notificationList[index]['time'],
                    //   style: TextStyle(
                    //     color: Colors.white.withOpacity(0.8),
                    //     fontSize: 14.sp,
                    //   ),
                    // ),
                  ],
                ),
                trailing: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Color(0xFFFFDF00),
                      size: 20,
                    ),
                  ],
                ),
              ));
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 100.w,
            child: Divider(
              indent: 22,
              endIndent: 22,
              color: Colors.white.withOpacity(0.1),
              thickness: 2,
            ),
          );
        },
        itemCount: notificationController.notificationList.length,
      ),
    );
  }
}
