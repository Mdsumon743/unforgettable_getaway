import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/route/route.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/home/controller/home_controller.dart';
import 'package:unforgettable_getaway/feature/home/presentation/widget/select_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  image: AssetImage(Assetpath.creative),
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 40.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assetpath.logo,
                      height: 64.h,
                      width: 256.w,
                    ),
                    SizedBox(height: 20.h),
                    CustomTextPopins(
                      text: "Welcome to\nUnforgettable Getaway",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      size: 28.sp,
                    ),
                    SizedBox(height: 30.h),
                    Obx(() => SelectButton(
                          tittle: "Book Tour",
                          sub:
                              "Explore exciting destinations\nand book your next adventure.",
                          image: Assetpath.tour,
                          isActive: controller.selectedIndex.value == 0,
                          onTap: () => controller.selectButton(0),
                        )),
                    SizedBox(height: 20.h),
                    Obx(() => SelectButton(
                          tittle: "Find A Date",
                          sub:
                              "Connect with people\nworldwide & make new friends.",
                          image: Assetpath.date,
                          isActive: controller.selectedIndex.value == 1,
                          onTap: () => controller.selectButton(1),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: Padding(
            padding: EdgeInsets.only(left: 30.r),
            child: Obx(
              () => CustomButton(
                text: "Get Started",
                textColor: controller.isSelect.value
                    ? Colors.black
                    : Colors.black.withOpacity(0.2),
                borderRadius: 40.r,
                backgroundColor: controller.isSelect.value
                    ? AppColors.yellowColor
                    : AppColors.yellowColor.withOpacity(0.3),
                onPressed: () {
                  if (controller.selectedIndex.value == 0) {
                    Get.offAll(AppRoute.meet);
                  }
                },
              ),
            )),
      ),
    );
  }
}
