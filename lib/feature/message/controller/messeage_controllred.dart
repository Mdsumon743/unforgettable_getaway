import 'package:get/get.dart';

class MesseageController extends GetxController {

  
  
  var isSwitched = false.obs;
  void toggleSwitch(bool value) {
    isSwitched.value = value;
  }

  var selectedOption = ''.obs;
  void selectOption(String value) {
    selectedOption.value = value;
  }

  var messages = <String>[].obs;
  var isSecondMessageTriggered = false.obs;

  void sendMessage(String message) {
    messages.insert(0, message);
    if (messages.length == 2) {
      isSecondMessageTriggered.value = true;
    }
  }

  var messages1 = <String>[].obs;
  void sendMessage1(String message) {
    messages1.insert(0, message);
  }
}
