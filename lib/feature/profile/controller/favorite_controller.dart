import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';

import '../../../core/network_caller/service/service.dart';
import '../../../core/network_caller/utils/utils.dart';

class FavoriteController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();

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
}
