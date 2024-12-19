import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/home/presentation/widget/select_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
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
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextPopins(
                      text: "Welcome to\nUnforgettable Getaway",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      size: 28.sp,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    const SelectButton(
                        tittle: "Book Tour",
                        sub:
                            "Explore exciting destinations\nand book your next adventure.",
                        image: Assetpath.tour),
                    SizedBox(
                      height: 20.h,
                    ),
                    const SelectButton(
                        tittle: "Find A Date",
                        sub:
                            "Connect with people\nworldwide & make new friends.",
                        image: Assetpath.date)
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton:  Padding(
          padding: EdgeInsets.only(left:  30.r),
          child: CustomButton(
            text: "Get Started",
            textColor: Colors.black,
            borderRadius:  20.r,
            backgroundColor: AppColors.yellowColor,
          ),
        ),
      ),
    );
  }
}
