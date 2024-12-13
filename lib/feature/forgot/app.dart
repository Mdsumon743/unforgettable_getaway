import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:unforgettable_getaway/feature/forgot/core/color/app_color.dart';
import 'package:unforgettable_getaway/feature/forgot/core/route/app_route.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context,child)=>
            GetMaterialApp(
              debugShowCheckedModeBanner: false,
              color: AppColors.blackyDarker,
              theme: ThemeData(
                useMaterial3: true,
              ),
              getPages: AppRouts.routes,
              initialRoute: AppRouts.otpScreen,
            ));
  }
}