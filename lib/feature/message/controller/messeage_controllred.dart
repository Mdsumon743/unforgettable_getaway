import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/feature/message/controller/web_soket_controller.dart';

class MesseageController extends GetxController {
  var isSwitched = false.obs;
  var selectedOption = ''.obs;
  var messages = <String>[].obs;
  var messagesSender =
      <String>[].obs; // Keeps track of the sender of each message
  var isSecondMessageTriggered = false.obs;
  var chatroomId = ''.obs; // Stores the current chatroom ID
  String userid = ''; // Stores the current user's ID

  final WebSoketController webSocketController = WebSoketController();

  // Initialize the controller with userid
  MesseageController(String userid) {
    this.userid = userid;
  }

  @override
  void onInit() {
    super.onInit();
    webSocketController.initSocket();
    debugPrint("WebSocket initialized.");
    webSocketController.setOnMessageReceived((message) {
      debugPrint("Received WebSocket message: $message");
      _handleIncomingMessage(message);
    });
  }

  void toggleSwitch(bool value) {
    isSwitched.value = value;
    debugPrint("Switch toggled: $value");
  }

  void selectOption(String value) {
    selectedOption.value = value;
    debugPrint("Selected option: $value");
  }

  void initializeChat(String user1Id, String user2Id) {
    joinChatRoom(user1Id, user2Id);
    debugPrint("Initializing chat between $user1Id and $user2Id");
  }

  // void sendMessage(String senderId, String receiverId, String content) {
  //   if (content.isNotEmpty && chatroomId.isNotEmpty) {
  //     debugPrint("Sending message: $content");
  //     sendMessageRealtime(chatroomId.value, senderId, receiverId, content);
  //   } else {
  //     debugPrint(
  //         "Failed to send message. Chatroom ID is empty or content is empty.");
  //   }
  // }

  void sendMessageRealtime(
      String chatroomId, String senderId, String receiverId, String content) {
    webSocketController.sendMessage(chatroomId, senderId, receiverId, content);
    messages.insert(0, content);
    messagesSender.insert(
        0, 'user'); // Indicates the message is sent by the user
    debugPrint("Message sent: $content");
  }

  void joinChatRoom(String user1Id, String user2Id) {
    webSocketController.joinRoom(user1Id, user2Id);
    debugPrint("Joined chat room with $user1Id and $user2Id");
  }

  void _handleIncomingMessage(String rawMessage) {
    final decodedMessage = jsonDecode(rawMessage);

    debugPrint("Handling incoming message: $decodedMessage");

    if (decodedMessage['type'] == 'loadMessages') {
      final conversation = decodedMessage['conversation'];
      if (conversation != null && conversation['id'] != null) {
        chatroomId.value = conversation['id'];
        debugPrint("Chatroom ID assigned: ${chatroomId.value}");

        if (conversation['messages'] != null) {
          messages.clear();
          messagesSender.clear();

          for (var msg in conversation['messages']) {
            messages.add(msg['content']);
            // Compare senderId with userid to determine alignment
            messagesSender.add(msg['senderId'] == userid ? 'user' : 'other');
          }
          debugPrint("Loaded messages: ${conversation['messages']}");
        }
      }
    } else if (decodedMessage['type'] == 'receiveMessage' ||
        decodedMessage['type'] == 'messageSent') {
      // Handle incoming real-time messages
      final message = decodedMessage['message'];
      if (message != null) {
        messages.insert(0, message['content']);
        messagesSender.insert(
            0, message['senderId'] == userid ? 'user' : 'other');
        debugPrint("Real-time message received: ${message['content']}");
      }
    }
  }

  bool isUserMessage(int index) {
    debugPrint(
        "Checking if message at index $index is user message: ${messagesSender[index] == 'user'}");
    return messagesSender[index] == 'user';
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
