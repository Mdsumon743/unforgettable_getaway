import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneVerificationController extends GetxController {
  var selectedCountryCode = '+1'.obs;
  var phoneNumber = ''.obs;
  var phonenumbertotal = ''.obs;

  void updateCountryCode(String code) {
    selectedCountryCode.value = code;
    debugPrint('Selected Country Code=======>>>>>: $code');
  }

  void updatePhoneNumber(String number) {
    phoneNumber.value = number;
    debugPrint('Selected Country Number=======>>>>>: $number');
    debugPrint(
        'Selected Country Number=======>>>>>: ${selectedCountryCode + phoneNumber.value}');
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var verificationId = ''.obs;
  var isCodeSent = false.obs;
  var isLoading = false.obs;

  Future<void> sendOtp() async {
    _auth.setSettings(appVerificationDisabledForTesting: true);
    phonenumbertotal.value = selectedCountryCode + phoneNumber.value;
    try {
      isLoading.value = true;
      await _auth.verifyPhoneNumber(
        phoneNumber: selectedCountryCode.value + phoneNumber.value,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          Get.snackbar("Success", "Phone number verified automatically!");
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("Error", e.message ?? "Verification failed");
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId.value = verificationId;
          isCodeSent.value = true;
          Get.snackbar(
              "OTP Sent", "Check your phone for the verification code.");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId.value = verificationId;
        },
      );
    } catch (e) {
      Get.snackbar("Error", "Failed to send OTP: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String otp) async {
    try {
      isLoading.value = true;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      Get.snackbar("Success", "Phone number verified successfully!");
    } catch (e) {
      Get.snackbar("Error", "Invalid OTP, please try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
