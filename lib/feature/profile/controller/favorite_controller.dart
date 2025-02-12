import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';

import '../../../core/network_caller/service/service.dart';
import '../../../core/network_caller/utils/utils.dart';
import '../../meet_people/model/all_profile.dart';

class FavoriteController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  RxList<ProfileResponse> favoriteMeList = <ProfileResponse>[].obs;
  RxList<ProfileResponse> whoFavoriteMe = <ProfileResponse>[].obs;
  RxBool isLoading = false.obs;

  Future<void> addFavoritList(String id) async {
    await preferencesHelper.init();
    String? token = preferencesHelper.getString("userToken");
    if (token != null) {
      try {
        final response = await NetworkCaller().postRequest(
          Utils.baseUrl + Utils.favorite,
          token: token,
          body: {"favoritedUserId": id},
        );

        if (response.isSuccess) {
          debugPrint("Favorite Added");
        }
      } catch (e) {
        debugPrint("=============Error: $e");
      }
    } else {
      debugPrint("Token is null");
    }
  }

  Future<void> whofavoritesMe() async {
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");

    if (token != null) {
      isLoading.value = true;
      try {
        final response = await NetworkCaller()
            .getRequest(Utils.baseUrl + Utils.whoFavoriteMe, token: token);

        if (response.isSuccess) {
          final jsonData = response.responseData;

          if (jsonData is Map<String, dynamic>) {
            if (jsonData['success'] == true && jsonData['data'] is List) {
              List<dynamic> dataList = jsonData['data'];
              whoFavoriteMe.addAll(
                  dataList.map((e) => ProfileResponse.fromJson(e)).toList());
              debugPrint("Profiles retrieved: ${whoFavoriteMe.length}");
            } else {
              debugPrint("Invalid response data structure");
            }
          } else if (jsonData is List) {
            whoFavoriteMe.addAll(
                jsonData.map((e) => ProfileResponse.fromJson(e)).toList());
            debugPrint("whoFavorite retrieved: ${whoFavoriteMe.length}");
          } else {
            debugPrint("Unexpected response format");
          }
        } else {
          debugPrint("Failed to retrieve data: ${response.responseData}");
        }
      } catch (e) {
        isLoading.value = false;
        debugPrint("Error occurred: $e");
      } finally {
        isLoading.value = false;
      }
    } else {
      debugPrint("Token is null");
    }
    update();
  }

  Future<void> myFavoriteList() async {
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");

    if (token != null) {
      isLoading.value = true;
      try {
        final response = await NetworkCaller()
            .getRequest(Utils.baseUrl + Utils.whoIFavorite, token: token);

        if (response.isSuccess) {
          final jsonData = response.responseData;

          if (jsonData is Map<String, dynamic>) {
            if (jsonData['success'] == true && jsonData['data'] is List) {
              List<dynamic> dataList = jsonData['data'];
              favoriteMeList.addAll(
                  dataList.map((e) => ProfileResponse.fromJson(e)).toList());
              debugPrint("Profiles retrieved: ${whoFavoriteMe.length}");
            } else {
              debugPrint("Invalid response data structure");
            }
          } else if (jsonData is List) {
            favoriteMeList.addAll(
                jsonData.map((e) => ProfileResponse.fromJson(e)).toList());
            debugPrint("favoriteMe  retrieved: ${whoFavoriteMe.length}");
          } else {
            debugPrint("Unexpected response format");
          }
        } else {
          debugPrint("Failed to retrieve data: ${response.responseData}");
        }
      } catch (e) {
        isLoading.value = false;
        debugPrint("Error occurred: $e");
      } finally {
        isLoading.value = false;
      }
    } else {
      debugPrint("Token is null");
    }
    update();
  }

  Future<void> deleteFavoritList(String id) async {
    await preferencesHelper.init();
    String? token = preferencesHelper.getString("userToken");
    if (token != null) {
      try {
        final response = await NetworkCaller().deleteRequest(
          Utils.baseUrl + Utils.deleteFavorite,
          token: token,
          body: {"favoritedUserId": id},
        );

        if (response.isSuccess) {
          debugPrint("Favorite Added");

          debugPrint("Favorite Removed");
        }
      } catch (e) {
        debugPrint("=============Error: $e");
      }
    } else {
      debugPrint("Token is null");
    }
  }

  @override
  void onInit() {
    super.onInit();
    whofavoritesMe();
    myFavoriteList();
  }
}
