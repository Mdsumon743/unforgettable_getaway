import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';
import 'package:unforgettable_getaway/feature/message/model/model.dart';

import '../../../core/network_caller/service/service.dart';
import '../../../core/network_caller/utils/utils.dart';

class ChatlistController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

  RxBool isLoading = false.obs;
  RxList<ChatData> allChatList = <ChatData>[].obs;

  Timer? _pollingTimer;

  Future<void> getMyChatList() async {
    try {
      await preferencesHelper.init();
      var token = preferencesHelper.getString("userToken");
      debugPrint("Token: $token");

      if (token != null) {
        isLoading.value = true;

        final response = await NetworkCaller()
            .getRequest(Utils.baseUrl + Utils.getMyChatList, token: token);

        debugPrint("[LOG] Response Status: ${response.isSuccess}");
        debugPrint("[LOG] Response Body: ${response.responseData}");

        final responseData = response.responseData;

        if (response.isSuccess) {
          if (responseData is List) {
            debugPrint("[LOG] Raw list format detected.");
            allChatList.value = responseData
                .map((item) => ChatData.fromJson(item as Map<String, dynamic>))
                .toList();
            debugPrint("[LOG] ${allChatList.length}");
          } else if (responseData is Map<String, dynamic> &&
              responseData.containsKey('data')) {
            debugPrint("[LOG] Object format detected.");
            final dataList = responseData['data'] as List<dynamic>;
            allChatList.value = dataList
                .map((item) => ChatData.fromJson(item as Map<String, dynamic>))
                .toList()
                .followedBy(allChatList)
                .toList();
          } else {
            debugPrint("[ERROR] Unexpected response format: $responseData");
          }
        } else {
          debugPrint(
              "[ERROR] Failed to retrieve data: ${response.responseData}");
        }
      } else {
        debugPrint("[ERROR] Token is null");
      }
    } catch (e) {
      debugPrint("[ERROR] Exception occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
    debugPrint("[LOG] Polling stopped.");
  }
}
