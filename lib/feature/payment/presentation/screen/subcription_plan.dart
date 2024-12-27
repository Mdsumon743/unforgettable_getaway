import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/payment/presentation/screen/payment_method.dart';

import '../../controller/subcribtion_plan.dart';
import '../widget/custom_plan.dart';

class SubscriptionPlan extends StatelessWidget {
  SubscriptionPlan({super.key});

  final SubscriptionController controller = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1A1110),
      appBar: AppBar(
        backgroundColor: const Color(0xff1A1110),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: CustomTextPopins(
          text: "Subscribe Plans",
          size: 20.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextPopins(
                text: "Choose your plan",
                size: 24.sp,
                color: Colors.white,
              ),
              const SizedBox(height: 32),
              Obx(() => CustomPlan(
                    tittle: 'Weekly Plan',
                    sub: '\$8.95 / 7 Days',
                    isSelected: controller.selectedPlan.value == 'Weekly Plan',
                    onTap: () {
                      controller.selectPlan('Weekly Plan');
                    },
                  )),
              const SizedBox(height: 24),
              Obx(() => CustomPlan(
                    tittle: 'Monthly Plan',
                    sub: '\$15.35 / 30 Days',
                    isSelected: controller.selectedPlan.value == 'Monthly Plan',
                    onTap: () {
                      controller.selectPlan('Monthly Plan');
                    },
                  )),
              const SizedBox(height: 24),
              Obx(() => CustomPlan(
                    tittle: 'Yearly Plan',
                    sub: '\$45.55 / 1 Year',
                    isSelected: controller.selectedPlan.value == 'Yearly Plan',
                    onTap: () {
                      controller.selectPlan('Yearly Plan');
                    },
                  )),
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Image.asset(
                    Assetpath.blink2,
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(
                    width: 8.h,
                  ),
                  const CustomTextPopins(
                    text: 'Unlimited Message',
                    fontWeight: FontWeight.w500,
                    size: 13,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Image.asset(
                    Assetpath.blink2,
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(
                    width: 8.h,
                  ),
                  const CustomTextPopins(
                    text: 'Unlimited Audio & Video Call',
                    fontWeight: FontWeight.w500,
                    size: 13,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Image.asset(
                    Assetpath.blink2,
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(
                    width: 8.h,
                  ),
                  const CustomTextPopins(
                    text: 'Unlimited Fun & Enjoy',
                    fontWeight: FontWeight.w500,
                    size: 13,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 75.h,
              ),
              SizedBox(
                height:48.h,
                width:335.w,
                child: Obx(() => ElevatedButton(
                      onPressed: controller.selectedPlan.value.isNotEmpty

                          ? () {
                              Get.to(() =>  const PaymentMethod());
                            }
                          : null,
                      style: ElevatedButton.styleFrom(

                        backgroundColor:
                            controller.selectedPlan.value.isNotEmpty
                                ? const Color(0xffFFDF00)
                                : Colors.grey, // Button color changes
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                      ),
                      child:  const Text(
                        'Subscribe Now',
                        style: TextStyle(
                          fontWeight:FontWeight.w500,
                           fontSize:18,

                          color: Color(0xff333329),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
