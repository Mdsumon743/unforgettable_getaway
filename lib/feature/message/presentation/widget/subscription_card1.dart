import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/message/presentation/screen/chat/completed_premium.dart';

class SubcriptionCard1 extends StatelessWidget {
  final String img;
  final String text;
  const SubcriptionCard1({
     required this.img,
     required this.text,
     super.key,
   });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                image: const DecorationImage(
                    image: AssetImage(Assetpath.subcription),
                    fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextPopins(
                  text: "Upgrade to Premium\nSubscription",
                  fontWeight: FontWeight.w600,
                  size: 16.sp,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Image.asset(
                      Assetpath.blink,
                      height: 20.h,
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=> CompletedPremium(
                       img: img ,
                          text: text,
                        ));
                      },
                      child: CustomTextPopins(
                        text: "Unlimited Message",
                        fontWeight: FontWeight.w500,
                        size: 12.sp,
                        color: const Color(0xff333329),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Image.asset(
                      Assetpath.blink,
                      height: 20.h,
                      width: 20.w,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomTextPopins(
                      text: "Unlimited Audio & Video Call",
                      fontWeight: FontWeight.w500,
                      size: 12.sp,
                      color: const Color(0xff333329),
                    )
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(80, 23),
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {},
                    child: CustomTextPopins(
                      text: "Learn More",
                      color: const Color(0xffFFDF00),
                      fontWeight: FontWeight.w500,
                      size: 10.sp,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
