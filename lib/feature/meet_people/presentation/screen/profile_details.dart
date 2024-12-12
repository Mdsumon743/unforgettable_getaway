import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/widget/build_details.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const SizedBox(),
            expandedHeight: 380.h,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
              Assetpath.profile1,
              fit: BoxFit.fill,
              width: double.infinity,
            )),
          ),
          buildDetails()
        ],
      ),
    );
  }
}
