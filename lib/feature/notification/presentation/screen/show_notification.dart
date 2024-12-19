import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/feature/notification/controller/notification_controller.dart';
import 'package:unforgettable_getaway/feature/notification/presentation/screen/empty_notification.dart';
import 'package:unforgettable_getaway/feature/notification/presentation/screen/notification.dart';

class ShowNotification extends StatelessWidget {
  const ShowNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final notificaitonController = Get.put(NotificationController());
    return Obx(() => notificaitonController.notificationList.isEmpty
        ? const EmptyNotificationPage()
        : const NotificationPage());
  }
}
