import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_textfield.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/payment/controller/PaymentController.dart';
import 'package:unforgettable_getaway/feature/payment/presentation/screen/final_page.dart';
import 'package:unforgettable_getaway/feature/payment/presentation/widget/custom_payment.dart';

import '../../../../core/global_widget/custom_text_popins.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController paymentcontroller = Get.put(PaymentController());
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
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: [
              CustomTextPopins(
                text: "Choose payment method",
                size: 24.h,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  SizedBox(width: 1.5.h),
                  CustomTextPopins(
                    text: "We use secure transmission",
                    size: 14.h,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 9.h,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  SizedBox(width: 1.5.h),
                  CustomTextPopins(
                    text: "We protect your personal information",
                    size: 14.h,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              Obx(
                () => CustomPayment(
                  title: 'Credit Card',
                  img: Assetpath.creditcard,
                  height: 24.h,
                  weight: 31.5.w,
                  isSelected:
                      paymentcontroller.selectedPayment.value == 'credit_card',
                  onTap: () {
                    paymentcontroller.selectPlan('credit_card');
                  },
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Obx(
                () => CustomPayment(
                  title: 'Visa',
                  img: Assetpath.visa,
                  height: 24.h,
                  weight: 31.5.w,
                  isSelected:
                      paymentcontroller.selectedPayment.value == 'visa_card',
                  onTap: () {
                    paymentcontroller.selectPlan('visa_card');
                  },
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Obx(
                () => CustomPayment(
                  title: 'Paypal',
                  img: Assetpath.paypal,
                  height: 24.h,
                  weight: 31.5.w,
                  isSelected:
                      paymentcontroller.selectedPayment.value == 'paypal',
                  onTap: () {
                    paymentcontroller.selectPlan('paypal');
                  },
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Obx(
                () => CustomPayment(
                  title: 'Apple Pay',
                  img: Assetpath.pay,
                  height: 24.h,
                  weight: 31.5.w,
                  isSelected:
                      paymentcontroller.selectedPayment.value == 'apple_pay',
                  onTap: () {
                    paymentcontroller.selectPlan('apple_pay');
                  },
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Obx(
                () => CustomPayment(
                  title: 'Google Pay',
                  img: Assetpath.gpay,
                  height: 24.h,
                  weight: 31.5.w,
                  isSelected:
                      paymentcontroller.selectedPayment.value == 'google_pay',
                  onTap: () {
                    paymentcontroller.selectPlan('google_pay');
                  },
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Divider(
                thickness: 1.r,
                color: Color(0xffFFFFFF),
              ),
              SizedBox(
                height: 24.h,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTextPopins(
                    text: 'Email*',
                    size: 14.h,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  )),
              SizedBox(
                height: 8.h,
              ),
              CustomTextField(),
              SizedBox(
                height: 24.h,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTextPopins(
                    text: 'Name on Card*',
                    size: 14.h,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  )),
              SizedBox(
                height: 8.h,
              ),
              CustomTextField(),
              SizedBox(
                height: 24.h,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTextPopins(
                    text: 'Card Number*',
                    size: 14.h,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  )),
              SizedBox(
                height: 8.h,
              ),
         Obx(()=>CustomTextField(suffix:Padding(
           padding: const EdgeInsets.symmetric(horizontal: 10),
           child: Image.asset(paymentcontroller.img.value,height: 14.h,width: 43.w,),
         ),)),
              SizedBox(
                height: 24.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextPopins(
                          text: 'Expiration Date*',
                          size: 14.h,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextPopins(
                          text: 'CVC*',
                          size: 14.h,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        CustomTextField(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextPopins(
                      text: 'Billing ZIP Code',
                      size: 14.h,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      width: 160.w,
                      child: CustomTextField(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60.h),
              SizedBox(
                height: 48.h,
                width: 335.w,
                child: Obx(() => ElevatedButton(
                      onPressed:
                          paymentcontroller.selectedPayment.value.isNotEmpty
                              ? () {
                                  Get.to(() => FinalPage());
                                }
                              : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            paymentcontroller.selectedPayment.value.isNotEmpty
                                ? const Color(0xffFFDF00)
                                : Colors.grey, // Button color changes
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                      ),
                      child: Text(
                        'Confirm Purchase',
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
