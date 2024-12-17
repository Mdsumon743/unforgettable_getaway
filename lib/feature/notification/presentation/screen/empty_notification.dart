import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';


class EmptyNotificationPage extends StatelessWidget {
  const EmptyNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: (){
            // Get.to(()=> NotificationPage());
          },
            child: const Icon(Icons.arrow_back, color: Colors.white)),
        centerTitle: true,
        title: Text(
          "Notification",
          style: GoogleFonts.poppins(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFFFFFFF),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assetpath.noti3),
            Text(
              "No notifications yet",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              '''   Come back here to get information about \n        match and messages, profile insights 
                          amd much more!''',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(0.85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}