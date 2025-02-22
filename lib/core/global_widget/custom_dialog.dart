import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:unforgettable_getaway/feature/auth/controller/login_controller.dart';

class CustomSuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;

  const CustomSuccessDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Obx(() => loginController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.yellowColor,
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: AppColors.yellowColor,
                        ),
                      ))
                // : ElevatedButton(
                //     onPressed: onConfirm,
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.amber,
                //       foregroundColor: Colors.white,
                //       elevation: 3,
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 24.0, vertical: 12.0),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12.0),
                //       ),
                //     ),
                //     child: const Text(
                //       'Login',
                //       style: TextStyle(fontSize: 16),
                //     ),
                //   )),
              ],
            ),
          ),
          const Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: Colors.amber,
              radius: 50,
              child: Icon(
                Icons.check_rounded,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
