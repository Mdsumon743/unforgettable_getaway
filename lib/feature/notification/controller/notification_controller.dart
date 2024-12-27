

// ignore_for_file: avoid_print


import 'dart:convert';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

class NotificationController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  var notificationList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeLocalNotifications();
    configureNotificationListener();
    getAndSaveFCMToken();
    getSavedNotifications();
  }

  void _initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    _localNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> getAndSaveFCMToken() async {
    try {
      await _firebaseMessaging.requestPermission();

      String? fcmToken = await _firebaseMessaging.getToken();

      if (fcmToken != null) {
        await preferencesHelper.init();
        await preferencesHelper.setString('fcm_token', fcmToken);

        print("FCM Token: $fcmToken");
      } else {
        print("Failed to get FCM token.");
      }
    } catch (e) {
      print("Error getting FCM token: $e");
    }
  }

  Future<String?> getSavedFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcm_token');
  }

  void configureNotificationListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Notification received:");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");
      print("Data: ${message.data}");

      _showLocalNotification(
        title: message.notification?.title ?? 'No Title',
        body: message.notification?.body ?? 'No Body',
      );

      _saveNotificationToList(
        title: message.notification?.title ?? 'No Title',
        subtitle: message.notification?.body ?? 'No Body',
        time:
            "${DateTime.now().difference(DateTime.now().subtract(const Duration(minutes: 1))).inMinutes} minutes ago",
        leading: Assetpath.noti2,
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Notification opened:");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");
      print("Data: ${message.data}");
    });
  }

  void _showLocalNotification(
      {required String title, required String body}) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  Future<void> _saveNotificationToList({
    required String title,
    required String subtitle,
    required String time,
    required String leading,
  }) async {
    try {
      await preferencesHelper.init();
      List<String> notifications =
          preferencesHelper.getStringList('notifications') ?? [];

      Map<String, dynamic> notification = {
        'title': title,
        'subtitle': subtitle,
        'time': time,
        'leading': leading,
      };

      notifications.insert(0, jsonEncode(notification));

      await preferencesHelper.setStringList('notifications', notifications);

      notificationList.insert(0, notification);

      print("Notification saved: $notification");
    } catch (e) {
      print("Error saving notification: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getSavedNotifications() async {
    await preferencesHelper.init();
    List<String> notifications =
        preferencesHelper.getStringList('notifications') ?? [];

    notificationList.value = notifications
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .toList();
    return notificationList;
  }
}
