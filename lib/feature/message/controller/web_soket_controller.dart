import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSoketController extends GetxController {
  WebSocketChannel? _channel;
  Function(String)? onMessageReceived;

  void setOnMessageReceived(Function(String) callback) {
    onMessageReceived = callback;
  }

  void sendMessage(
      String chatroomId, String senderId, String receiverId, String content) {
    final message = jsonEncode({
      'type': 'sendMessage',
      'chatroomId': chatroomId,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
    });

    _channel?.sink.add(message);

    debugPrint('Message sent to WebSocket: $message');
  }

  void sendOffer(String roomId, String receiverId, String sdp) {
    final offerMessage = jsonEncode({
      'type': 'offer',
      'offer': {
        'type': 'sendOffer',
        'sdp': sdp,
      },
      'receiverId': receiverId,
      'roomId': roomId,
    });

    _channel?.sink.add(offerMessage);

    debugPrint('Offer sent to WebSocket: $offerMessage');
  }

  void initSocket() {
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://192.168.11.20:5003'),
    );

    _channel?.stream.listen(
      (message) {
        debugPrint('Received WebSocket message: $message');
        onMessageReceived?.call(message);
      },
      onError: (error) {
        debugPrint('WebSocket error: $error');
      },
      onDone: () {
        debugPrint('WebSocket connection closed');
      },
    );

    debugPrint("WebSocket initialized and connected.");
  }

  void joinRoom(String user1Id, String user2Id) {
    final message = jsonEncode({
      'type': 'joinRoom',
      'user1Id': user1Id,
      'user2Id': user2Id,
    });
    _channel?.sink.add(message);
    if (kDebugMode) {
      print(
          '=============Joined room with user1Id: $user1Id and user2Id: $user2Id');
    }
  }

  void emitTyping(String typingRoomId, String username) {
    final message = jsonEncode({
      'type': 'typing',
      'typingRoomId': typingRoomId,
      'username': username,
    });
    _channel?.sink.add(message);
    if (kDebugMode) {
      print('Typing notification sent for username: $username');
    }
  }

  void disconnect() {
    try {
      _channel?.sink.close(1000);
      if (kDebugMode) {
        print('WebSocket connection closed successfully.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error while closing WebSocket: $e');
      }
    }
  }
}
