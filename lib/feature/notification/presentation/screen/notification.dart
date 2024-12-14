import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        "title": "Booking Cancelled",
        "subtitle": "Your booking for Paris has \ncancelled",
        "time": "42 minutes ago",
        "leading": Assetpath.boking,
        "size": true,
      },
      {
        "title": "Ama Likes your profile  ",
        "subtitle": "",
        "time": "15 minutes ago",
        "leading": Assetpath.noti2,
      },
      {
        "title": "Cristian Likes your \nprofile",
        "subtitle": "",
        "time": "15 minutes ago",
        "leading": Assetpath.noti2,
      },
      {
        "title": "Lea Rose loves your \nprofile",
        "subtitle": "",
        "time": "1 day ago",
        "leading": Assetpath.noti2,
      },
      {
        "title": "You have new conversation \nwith Lara",
        "subtitle": "",
        "time": "15 minutes ago",
        "leading": Assetpath.noti2,
      },
      {
        "title": "Chloe Mae Likes your \nprofile ",
        "subtitle": "",
        "time": "15 minutes ago",
        "leading": Assetpath.noti2,
      },
      {
        "title": "Jhony Likes your \nprofile ",
        "subtitle": "",
        "time": "15 minutes ago",
        "leading": Assetpath.noti2,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        leading: const Icon(
          Icons.arrow_back,
          weight: 24,
          color: Colors.white,
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
          return ListTile(
            leading: CircleAvatar(
              radius: 25.r,
              backgroundColor: Colors.white.withOpacity(0.2),
              child: Image.asset(
                data[index]['leading'],
                fit: BoxFit.cover,
                height: 28.h,
                width: 28.w,
                color: const Color(0xFFFFF9CC),
              ),
            ),
            title: Text(
              data[index]['title'],
              style: GoogleFonts.poppins(
                  fontSize: data[index]["size"] ?? false ? 16.sp : 14.sp,
                  fontWeight: data[index]["size"] ?? false
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: Colors.white),
            ),
            subtitle: data[index]['subtitle']!.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index]['subtitle']!,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        data[index]['time'],
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  )
                : Text(
                    data[index]['time'],
                    style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
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
          );
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
        itemCount: data.length,
      ),
    );
  }
}
