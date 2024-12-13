import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/widget/custom_gridview_profile.dart';

import '../../../../core/global_widget/custom_text_popins.dart';

class FavoritesList extends StatelessWidget {
  const FavoritesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xff1A1110),
        centerTitle: true,
        title: CustomTextPopins(
          text: "Profile",
          fontWeight: FontWeight.w500,
          size: 24.sp,
          color: Colors.white,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: const SingleChildScrollView(
        child: CustomGridviewProfile(),
      ),
    );
  }
}
