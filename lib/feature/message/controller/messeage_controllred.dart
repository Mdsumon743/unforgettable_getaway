import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';
import 'package:unforgettable_getaway/feature/message/controller/web_soket_controller.dart';

class MesseageController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  var isSwitched = false.obs;
  var selectedOption = ''.obs;
  var callId = ''.obs;
  var isSecondMessageTriggered = false.obs;
  var messages2 = [].obs;
  var messages = <Map<String, dynamic>>[].obs;
  var chatroomId = ''.obs;
  String userid = '';
  RxBool isTranslate = false.obs;
  RxString language = "en".obs;

  final WebSoketController webSocketController = WebSoketController();

  @override
  void onInit() {
    super.onInit();
    loadUserId();
    webSocketController.initSocket();
    debugPrint("WebSocket initialized.");
    webSocketController.setOnMessageReceived((message) {
      debugPrint("Received WebSocket message: $message");
      _handleIncomingMessage(message);
    });
  }

  void toggleSwitch(bool value) {
    if (value) {
      language.value = "es";
    } else {
      language.value = "en";
    }
    isSwitched.value = value;
    debugPrint("Switch toggled: $value");
    debugPrint("Language: $language");
  }

  Future<void> loadUserId() async {
    await preferencesHelper.init();
    userid = preferencesHelper.getString("userId") ?? "";
  }

  void selectOption(String value) {
    selectedOption.value = value;
    debugPrint("Selected option: $value");
  }

  void initializeChat(String user1Id, String user2Id) {
    joinChatRoom(user1Id, user2Id);
    debugPrint("Initializing chat between $user1Id and $user2Id");
  }

  void sendMessage(String senderId, String receiverId, String content) {
    if (content.isNotEmpty && chatroomId.isNotEmpty) {
      debugPrint("Sending message: $content");
      sendMessageRealtime(chatroomId.value, senderId, receiverId, content);
    } else {
      debugPrint(
          "Failed to send message. Chatroom ID is empty or content is empty.");
    }
  }

  void sendMessageRealtime(
      String chatroomId, String senderId, String receiverId, String content) {
    webSocketController.sendMessage(chatroomId, senderId, receiverId, content);

    debugPrint("Message sent: $content");
  }

  void joinChatRoom(String user1Id, String user2Id) {
    webSocketController.joinRoom(user1Id, user2Id);
    debugPrint("Joined chat room with $user1Id and $user2Id");
  }

  void _handleIncomingMessage(String rawMessage) async {
    debugPrint("============>>><><>Meeseage${isTranslate.value}");
    final decodedMessage = jsonDecode(rawMessage);

    if (decodedMessage['type'] == 'loadMessages') {
      final conversation = decodedMessage['conversation'];
      if (conversation != null && conversation['id'] != null) {
        chatroomId.value = conversation['id'];
        messages.clear();
        for (var msg in conversation['messages']) {
          if (isTranslate.value) {
            debugPrint("isTranlated ON manm ==============");
            final translatedContent =
                await translateTextToSpanish(msg['content']);
            _addMessage(translatedContent, msg['senderId']);
          } else {
            debugPrint("isTranlated Off manm ==============");
            _addMessage(msg['content'], msg['senderId']);
          }
        }
      }
    } else if (decodedMessage['type'] == 'receiveMessage' ||
        decodedMessage['type'] == 'messageSent') {
      final message = decodedMessage['message'];
      if (message != null) {
        if (isTranslate.value) {
          final translatedContent =
              await translateTextToSpanish(message['content']);
          _addMessage(translatedContent, message['senderId']);
        } else {
          _addMessage(message['content'], message['senderId']);
        }
      }
    }
  }

  void _addMessage(String content, String senderId) {
    if (!messages.any(
        (msg) => msg['content'] == content && msg['senderId'] == senderId)) {
      messages.add({'content': content, 'senderId': senderId});
      debugPrint("Added message: $content from $senderId");
      debugPrint("All Messeage============$messages");
    } else {
      debugPrint("Duplicate message ignored: $content from $senderId");
    }
  }

  bool isUserMessage(String senderId) {
    return senderId == userid;
  }

  Future<String> translateTextToSpanish(String text) async {
    const apiKey = 'AIzaSyCeCF3mAeGPc1WAAMpGwtQq1Mskp0e7DF8';

    final Uri url = Uri.parse(
        'https://translation.googleapis.com/language/translate/v2?key=$apiKey');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'q': text,
        'target': language.value,
      }),
    );
    debugPrint("================${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      debugPrint("======TranslateText=========${response.body}");
      return jsonResponse['data']['translations'][0]['translatedText'];
    } else {
      throw Exception('Failed to translate text: ${response.body}');
    }
  }

  Future<void> autoTranslateMessages() async {
    try {
      for (var message in messages) {
        if (message['translatedContent'] == null) {
          final translatedText =
              await translateTextToSpanish(message['content']);
          message['translatedContent'] = translatedText;
        }
      }
      messages.refresh();
      debugPrint("=======All messages auto-translated successfully.$messages");
    } catch (e) {
      debugPrint("Error during auto-translation: $e");
    }
  }

  @override
  void onClose() {
    try {
      webSocketController.disconnect();
      debugPrint("WebSocket connection closed successfully.");
    } catch (e) {
      debugPrint("Error while closing WebSocket: $e");
    }
    super.onClose();
  }
}
