import 'package:get/get.dart';
class SwitchController extends GetxController {
  var isSwitched = false.obs;
  void toggleSwitch(bool value) {
    isSwitched.value = value;
  }
}
class MessageController extends GetxController {
  var messages = <String>[].obs;
  var isSecondMessageTriggered = false.obs;

  void sendMessage(String message) {
    messages.insert(0, message);
    if (messages.length == 2) {
      isSecondMessageTriggered.value = true;
    }
  }
}

class MessageController1 extends GetxController {
  var messages1 = <String>[].obs;
  void sendMessage1(String message) {
    messages1.insert(0, message);
  }
}
