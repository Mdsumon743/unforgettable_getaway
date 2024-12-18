import 'package:get/get.dart';

class MessageController extends GetxController {
  var messages = <String>[].obs;
  void sendMessage(String message) {
    if (message.isNotEmpty) {
      messages.insert(0, message);
    }
  }
}
class SwitchController extends GetxController {
  var isSwitched = false.obs;
  void toggleSwitch(bool value) {
    isSwitched.value = value;
  }
}