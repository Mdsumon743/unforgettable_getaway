import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/screen/search_location.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkBrown,
      leading: const SizedBox(),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12.r),
              bottomRight: Radius.circular(12.r))),
      bottom: PreferredSize(
          preferredSize: preferredSize,
          child: Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
                color: AppColors.darkBrown,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.r),
                    bottomRight: Radius.circular(12.r))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextPopins(
                          text: 'Hello, Kim David 👋',
                          color: Colors.white,
                          size: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            Image.asset(Assetpath.location),
                            SizedBox(
                              width: 5.w,
                            ),
                            CustomTextPopins(
                              text: 'Chiro, Egypt',
                              color: Colors.white,
                              size: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(Assetpath.notification),
                        SizedBox(
                          width: 10.w,
                        ),
                        Image.asset(Assetpath.menu),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextFieldSearch(
                  fillColor:const Color(0xff302827) ,
                  hintText: 'Cartagena, Colombia',
                  color: Colors.white,
                  prefixIcon: Image.asset(Assetpath.search),
                  suffixIcon: Image.asset(Assetpath.filter),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          )),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(165.h);
}
