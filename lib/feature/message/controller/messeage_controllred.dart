import 'package:get/get.dart';

class MessageController extends GetxController {
  var messages = <String>[].obs;
  var isSecondMessageTriggered = false.obs;
  void sendMessage(String message) {
    messages.add(message);
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
// class PremiumController extends GetxController {
//   var pri = false.obs;
//   void toggleSwitch1(String pri) {
//     pri.value = pri;
//   }
// }