import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  TextEditingController emailText = TextEditingController();
  TextEditingController passText = TextEditingController();
  TextEditingController confirmPaassText = TextEditingController();

 String? validatePasswordMatch(String? value) {
    if (value != passText.value.text) return "Passwords do not match";
    return null;
  }
}