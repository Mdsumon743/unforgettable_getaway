import 'package:get/get.dart';

class PhoneVerificationController extends GetxController {
  
  var selectedCountryCode = '+1'.obs;
  var phoneNumber = ''.obs;

  void updateCountryCode(String code) {
    selectedCountryCode.value = code;
  }

 
  void updatePhoneNumber(String number) {
    phoneNumber.value = number;
  }
}
