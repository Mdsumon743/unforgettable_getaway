import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_button.dart';
import 'package:unforgettable_getaway/core/global_widget/custom_textfield.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';
import 'package:unforgettable_getaway/feature/account_setup/presentation/screen/height_selection_screen.dart';
import 'package:unforgettable_getaway/feature/auth/presentation/screen/login_or_signup_screen.dart';
import 'package:unforgettable_getaway/feature/meet_people/presentation/screen/meet_people.dart';
import 'package:unforgettable_getaway/feature/payment/controller/PaymentController.dart';
import 'package:unforgettable_getaway/feature/payment/presentation/widget/custom_payment.dart';

import '../../../../core/global_widget/custom_text_popins.dart';
class FinalPage extends StatelessWidget {
  const FinalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1A1110),
      appBar:AppBar(
        backgroundColor: const Color(0xff1A1110),
        automaticallyImplyLeading: false,
        actions: [
         IconButton(onPressed: (){
           Get.to(()=>const MeetPeople());
           
         }, icon:Image.asset(Assetpath.cross,height: 24.h,width: 24.w,))

        ],

      ),
      body:Column(
        mainAxisAlignment:MainAxisAlignment.center,
        crossAxisAlignment:CrossAxisAlignment.center,
        children: [

          Image.asset(Assetpath.finalpic,height:360.h,width: 360.w,),
        CustomTextPopins(text: "Payment Successful",size:24.h,fontWeight:FontWeight.w600,color:Colors.white,),
        ],

         
      ),
    );
  }
}
