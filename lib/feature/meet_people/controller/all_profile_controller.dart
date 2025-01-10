import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/network_caller/service/service.dart';
import 'package:unforgettable_getaway/feature/meet_people/model/all_profile.dart';
import 'package:unforgettable_getaway/feature/message/controller/chatlist_controller.dart';
import 'package:unforgettable_getaway/feature/notification/controller/notification_controller.dart';
import 'package:unforgettable_getaway/feature/profile/controller/profile_controller.dart';
import 'dart:isolate';
import '../../../core/helper/shared_prefarences_helper.dart';
import '../../../core/network_caller/utils/utils.dart';

class AllProfileController extends GetxController {
  ChatlistController chatlistController = Get.put(ChatlistController());
  ProfileController profileController = Get.put(ProfileController());
  NotificationController notificationController =
      Get.put(NotificationController());
  RxBool isLoading = false.obs;
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  Timer? _pollingTimer;

  RxList<ProfileResponse> allProfiles = <ProfileResponse>[].obs;

  Future<void> getUserProfiles() async {
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");
    debugPrint("Token: $token");

    if (token != null) {
      isLoading.value = true;
      try {
        final response = await NetworkCaller()
            .getRequest(Utils.baseUrl + Utils.profile, token: token);
        debugPrint("Response Status: ${response.isSuccess}");
        debugPrint("Response Body: ${response.responseData}");

        if (response.isSuccess) {
          final jsonData = response.responseData;

          if (jsonData is Map<String, dynamic>) {
            if (jsonData['success'] == true && jsonData['data'] is List) {
              List<dynamic> dataList = jsonData['data'];
              await _processProfilesInIsolate(dataList);
              debugPrint("Profiles retrieved: ${allProfiles.length}");
              debugPrint("===========: ${allProfiles.length}");
            } else {
              debugPrint("Invalid response data structure");
            }
          } else if (jsonData is List) {
            await _processProfilesInIsolate(jsonData);
            debugPrint("Profiles retrieved: ${allProfiles.length}");
            debugPrint("Profiles =========: $allProfiles");
          } else {
            debugPrint("Unexpected response format");
          }
        } else {
          debugPrint("Failed to retrieve data: ${response.responseData}");
        }
      } catch (e) {
        debugPrint("Error occurred: $e");
      } finally {
        isLoading.value = false;
      }
    } else {
      debugPrint("Token is null");
    }
  }

  Future<void> _processProfilesInIsolate(List<dynamic> dataList) async {
    final receivePort = ReceivePort();

    await Isolate.spawn<List<dynamic>>(
      _isolateEntry,
      [receivePort.sendPort, dataList],
    );

    final result = await receivePort.first as List<ProfileResponse>;
    allProfiles.value = result;
  }

  static void _isolateEntry(List<dynamic> args) {
    final sendPort = args[0] as SendPort;
    final dataList = args[1] as List<dynamic>;

    final processedProfiles = dataList
        .map((profileData) => ProfileResponse.fromJson(profileData))
        .toList();

    sendPort.send(processedProfiles);
  }

  void startPolling({required Duration interval}) {
    _pollingTimer?.cancel();

    _pollingTimer = Timer.periodic(interval, (timer) async {
      await chatlistController.getMyChatList();
      await profileController.getUserProfiles();
      await notificationController.fetchNotifications();
    });

    debugPrint("[LOG] Polling started with interval: $interval");
  }

  @override
  void onInit() {
    super.onInit();
    getUserProfiles();
    startPolling(interval: const Duration(seconds: 30));
  }
}
