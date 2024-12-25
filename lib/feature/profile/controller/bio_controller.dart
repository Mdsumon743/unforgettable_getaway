import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';
import 'package:http/http.dart' as http;
import 'package:unforgettable_getaway/feature/profile/controller/profile_controller.dart';
import '../../../core/network_caller/utils/utils.dart';

class BioController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final ProfileController profileController = Get.put(ProfileController());
  RxString bio = "Edit".obs;
  RxBool isBio = false.obs;
  RxString interest = "Edit".obs;
  RxBool isinterest = false.obs;
  RxBool isLoading = false.obs;
  RxList favoriteList = [].obs;
  Map<String, dynamic> bodyData = {};

  void editBio() {
    isBio.value = !isBio.value;

    if (bio.value == "Update") {
      bioAddData();
      submitUserData();
      bio.value = "Edit";
    } else if (bio.value == "Edit") {
      bio.value = "Update";
    }
  }

  void editIntersted() {
    isinterest.value = !isinterest.value;

    if (interest.value == "Update") {
      bioAddData();
      submitUserData();
      interest.value = "Edit";
    } else if (interest.value == "Edit") {
      interest.value = "Update";
    }
  }

  TextEditingController bioController = TextEditingController();
  Map<String, dynamic> bioAddData() {
    Map<String, dynamic> data = {
      "about": bioController.text,
      "interests": favoriteList.toList(),
    };
    bodyData = data;

    debugPrint('====Data====: $data');
    return data;
  }

  void deleteFavoriteItemByIndex(int index) {
    if (index >= 0 && index < favoriteList.length) {
      final removedItem = favoriteList.removeAt(index);
      debugPrint(
          'The item "$removedItem" at index $index has been removed from the list.');
    } else {
      debugPrint('Invalid index: $index. Unable to remove item.');
    }
  }

  Future<void> submitUserData({File? profileImage}) async {
    await preferencesHelper.init();
    var token = preferencesHelper.getString("userToken");
    if (token != null) {
      try {
        final url = Uri.parse('${Utils.baseUrl}${Utils.profile}');
        debugPrint("============$url");
        var request = http.MultipartRequest('PUT', url);
        request.headers.addAll({
          'Authorization': 'Bearer $token',
        });
        request.fields['bodyData'] = jsonEncode(bodyData);
        if (profileImage != null) {
          request.files.add(await http.MultipartFile.fromPath(
            'profileImage',
            profileImage.path,
          ));
        }
        var streamedResponse = await request.send();

        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          debugPrint('====Success: ${response.body}');
        } else {
          debugPrint('====Error: ${response.statusCode}, ${response.body}');
        }
      } catch (e) {
        debugPrint('====An error occurred: $e');
      }
    }
  }

  void addFavoritList(String interestItem) {
    if (!favoriteList.contains(interestItem)) {
      if (favoriteList.length < 15) {
        favoriteList.add(interestItem);
      } else {
        debugPrint(
            'The list already contains 5 items. Remove an item to add a new one.');
      }
    } else {
      debugPrint('The item "$interestItem" is already in the list.');
    }
  }

  @override
  void onInit() {
    super.onInit();
    favoriteList.value = profileController.userData.value?.interests ?? [];
  }
}
