import 'package:get/get.dart';

class MessageController extends GetxController {
  var messages = <String>[].obs;
  void sendMessage(String message) {
    if (message.isNotEmpty) {
      messages.add(message);
    }
  }
}
