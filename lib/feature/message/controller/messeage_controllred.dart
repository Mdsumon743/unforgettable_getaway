import 'package:get/get.dart';

class MessageController extends GetxController {
  var messages = <String>[].obs;
  var isSecondMessageTriggered = false.obs;
  void sendMessage(String message) {
    messages.add(message);
    // if (message.isNotEmpty) {
    //   messages.insert(0, message);
    // }
    if(messages.length == 2){
      isSecondMessageTriggered.value = true;
    }
  }
}
class SwitchController extends GetxController {
  var isSwitched = false.obs;
  void toggleSwitch(bool value) {
    isSwitched.value = value;
  }
}
