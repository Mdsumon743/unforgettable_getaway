import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  RxInt genderSelectedValue = 0.obs;
  RxInt heightSelectedIndex = 2.obs;
  List favoriteList = [];

  void updatedValueGender(int value) {
    genderSelectedValue.value = value;
  }

  void selectHeight(int index) {
    heightSelectedIndex.value = index;
    debugPrint(heightSelectedIndex.value.toString());
  }

  void addFavoritList(String interestItem) {
    favoriteList.add(interestItem);
  }
}
