import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/network_caller/service/service.dart';
import 'package:unforgettable_getaway/feature/meet_people/model/all_profile.dart';
import 'package:unforgettable_getaway/feature/message/controller/chatlist_controller.dart';
import 'package:unforgettable_getaway/feature/notification/controller/notification_controller.dart';
import 'package:unforgettable_getaway/feature/payment/controller/subcribtion_plan.dart';
import 'package:unforgettable_getaway/feature/profile/controller/favorite_controller.dart';
import 'package:unforgettable_getaway/feature/profile/controller/profile_controller.dart';
import 'dart:isolate';
import '../../../core/helper/shared_prefarences_helper.dart';
import '../../../core/network_caller/utils/utils.dart';

class AllProfileController extends GetxController {
  ChatlistController chatlistController = Get.put(ChatlistController());
  ProfileController profileController = Get.put(ProfileController());
  FavoriteController favoriteController = Get.put(FavoriteController());
  String searchQuery = "".trim();
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  NotificationController notificationController =
      Get.put(NotificationController());
  RxBool subscribe = false.obs;
  RxBool isLoading = false.obs;
  RxString isSearch = "Search Here By City".obs;
  RxString text = "Nearest people around you".obs;
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  Timer? _pollingTimer;
  final TextEditingController textEditingController = TextEditingController();
  RxList<ProfileResponse> allProfiles = <ProfileResponse>[].obs;

  RxInt fvMe = 1.obs;
  RxInt fvList = 2.obs;

  Future<void> getUserProfiles() async {
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");

    if (token != null) {
      isLoading.value = true;
      try {
        final response = await NetworkCaller()
            .getRequest(Utils.baseUrl + Utils.profile, token: token);

        if (response.isSuccess) {
          allProfiles.refresh();

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
            allProfiles.refresh();
          } else if (jsonData is List) {
            await _processProfilesInIsolate(jsonData);
            debugPrint("Profiles retrieved: ${allProfiles.length}");
            debugPrint("Profiles =========: $allProfiles");
            allProfiles.refresh();
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
    update();
  }

  Future<void> getUserProfiles2() async {
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");

    if (token != null) {
      try {
        final response = await NetworkCaller()
            .getRequest(Utils.baseUrl + Utils.profile, token: token);

        if (response.isSuccess) {
          allProfiles.refresh();

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
            allProfiles.refresh();
          } else if (jsonData is List) {
            await _processProfilesInIsolate(jsonData);
            debugPrint("Profiles retrieved: ${allProfiles.length}");
            debugPrint("Profiles =========: $allProfiles");
            allProfiles.refresh();
          } else {
            debugPrint("Unexpected response format");
          }
        } else {
          debugPrint("Failed to retrieve data: ${response.responseData}");
        }
      } catch (e) {
        debugPrint("Error occurred: $e");
      } finally {}
    } else {
      debugPrint("Token is null");
    }
    update();
  }

  Future<void> itsSubscribe() async {
    debugPrint(" fucntion called");
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");

    if (token != null) {
      try {
        final response = await NetworkCaller()
            .getRequest(Utils.baseUrl + Utils.subcription, token: token);

        if (response.statusCode == 200) {
          subscribe.value = response.responseData;

          preferencesHelper.setBool("subscribe", subscribe.value);
          debugPrint("Subscribe==========>>>>>>>>: $subscribe");
        }
      } catch (e) {
        debugPrint("Error occurred: $e");
      }
    }
  }

  Future<void> favoriteMe() async {
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");

    if (token != null) {
      try {
        final response = await NetworkCaller()
            .getRequest(Utils.baseUrl + Utils.favoriteMe, token: token);
        debugPrint("Response Status: ${response.isSuccess}");
        debugPrint("Response Body: ${response.responseData}");
        if (response.isSuccess) {
          final data = response.responseData;
          debugPrint("=========>>>>>>>>>>Data: $data");
          fvMe.value = data['favoriteMe'];
          debugPrint("Favorite Me=========>>>>>: $fvMe");
        }
      } catch (e) {
        debugPrint("Error occurred: $e");
      }
    }
  }

  Future<void> favoriteList() async {
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");

    if (token != null) {
      try {
        final response = await NetworkCaller()
            .getRequest(Utils.baseUrl + Utils.favoriteList, token: token);
        debugPrint("Response Status: ${response.isSuccess}");
        debugPrint("Response Body: ${response.responseData}");
        if (response.isSuccess) {
          final data = response.responseData;
          debugPrint("=========>>>>>>>>>>Data: $data");
          fvList.value = data['favoriteList'];
          debugPrint("Favorite List=========>>>>>: $fvList");
        }
      } catch (e) {
        debugPrint("Error occurred: $e");
      }
    }
  }

  Future<void> getUserCity() async {
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");
    debugPrint("Token: $token");
    debugPrint("Search Query:==============>>>>>>>>>> $searchQuery");

    if (token != null) {
      isLoading.value = true;
      try {
        final response = await NetworkCaller().getRequest(
            Utils.baseUrl + Utils.profile + searchQuery.trim(),
            token: token);
        debugPrint("Response Status: ${response.isSuccess}");
        debugPrint("Response Body: ${response.responseData}");

        if (response.isSuccess) {
          allProfiles.clear();
          allProfiles.refresh();

          final jsonData = response.responseData;

          if (jsonData is Map<String, dynamic>) {
            if (jsonData['success'] == true && jsonData['data'] is List) {
              List<dynamic> dataList = jsonData['data'];
              allProfiles.addAll(
                  dataList.map((e) => ProfileResponse.fromJson(e)).toList());
              debugPrint("Profiles retrieved: ${allProfiles.length}");
            } else {
              debugPrint("Invalid response data structure");
            }
          } else if (jsonData is List) {
            allProfiles.addAll(
                jsonData.map((e) => ProfileResponse.fromJson(e)).toList());
            debugPrint("Profiles retrieved: ${allProfiles.length}");
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
    update();
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
      await notificationController.fetchNotifications();
      await favoriteMe();
      await favoriteList();
      await itsSubscribe();
      await profileController.getUserProfiles2();
    });

    debugPrint("[LOG] Polling started with interval: $interval");
  }

  @override
  void onInit() {
    super.onInit();
    getUserProfiles();
    subscriptionController.getAllPlan();
    chatlistController.getMyChatList();
    favoriteMe();
    itsSubscribe();
    favoriteList();
    startPolling(interval: const Duration(seconds: 10));
  }
}
