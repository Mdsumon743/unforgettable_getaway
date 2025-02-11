import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_text_popins.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/payment/controller/stripe_service.dart';

import '../../controller/subcribtion_plan.dart';
import '../widget/custom_plan.dart';

class SubscriptionPlan extends StatelessWidget {
  const SubscriptionPlan({super.key});

  @override
  Widget build(BuildContext context) {
    final SubscriptionController controller = Get.put(SubscriptionController());

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
              SizedBox(height: 32.h),
              ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.allPlan.length,
                itemBuilder: (context, index) {
                  final data = controller.allPlan[index];
                  return Padding(
                      padding: EdgeInsets.only(bottom: 24.0.r),
                      child: Obx(
                        () => CustomPlan(
                          tittle: data.planName,
                          sub: '\$${data.price} / ${data.duration} Days',
                          isSelected:
                              controller.selectedPlan.value == data.planName,
                          onTap: () {
                            controller.selectPlan(
                                data.planName, data.price, data.id);
                          },
                        ),
                      ));
                },
              ),
              SizedBox(
                height: 32.h,
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
                  CustomTextPopins(
                    text: 'Unlimited Message',
                    fontWeight: FontWeight.w500,
                    size: 13.sp,
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
                  CustomTextPopins(
                    text: 'Unlimited Audio & Video Call',
                    fontWeight: FontWeight.w500,
                    size: 13.sp,
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
                  CustomTextPopins(
                    text: 'Unlimited Fun & Enjoy',
                    fontWeight: FontWeight.w500,
                    size: 13.sp,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 75.h,
              ),
              SizedBox(
                height: 48.h,
                width: 335.w,
                child: Obx(() => controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: controller.selectedPlan.value.isNotEmpty
                            ? () {
                                StripeService.instance.setupPaymentMethod();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              controller.selectedPlan.value.isNotEmpty
                                  ? const Color(0xffFFDF00)
                                  : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.r),
                          ),
                        ),
                        child: const Text(
                          'Subscribe Now',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
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
