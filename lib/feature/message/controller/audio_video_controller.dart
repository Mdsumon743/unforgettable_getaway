import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';
import 'package:unforgettable_getaway/feature/message/controller/messeage_controllred.dart';
import 'package:unforgettable_getaway/feature/message/controller/web_soket_controller.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as rtc;

class CallController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final WebSoketController webSocketController = Get.put(WebSoketController());
  final MesseageController messeageController = Get.put(MesseageController());
  RxString senderId = "".obs;
  RxString waiting = "Waiting for remote video...".obs;

  RTCPeerConnection? _peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;

  var isAudioEnabled = true.obs;
  var isVideoEnabled = true.obs;
  var isInCall = false.obs;
  var currentMediaType = ''.obs;
  var otherId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserId();
    webSocketController.initSocket();
    webSocketController.setOnMessageReceived(_handleSignalingMessage);
  }

  Future<void> loadUserId() async {
    await preferencesHelper.init();
    String? userid = preferencesHelper.getString("userId");
    senderId.value = userid ?? "";
  }

  void _handleSignalingMessage(String message) async {
    debugPrint('Received signaling message: $message');
    final data = jsonDecode(message);
    final type = data['type'];

    switch (type) {
      case 'offer':
        debugPrint('Handling received offer: $data');
        _showIncomingCallDialog(data);
        break;
      case 'answer':
        debugPrint('Handling received answer: $data');
        await _handleAnswer(data);
        break;
      case 'candidate':
        debugPrint('Handling received ICE candidate: ${data['candidate']}');
        await _handleCandidate(data['candidate']);
        break;
      default:
        debugPrint('Unknown signaling message type: $type');
    }
  }

  void _showIncomingCallDialog(Map<String, dynamic> data) {
    Get.dialog(
      AlertDialog(
        title: const Text('Incoming Call'),
        content: Text('You have an incoming ${data['mediaType']} call.'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              _handleOffer(data);
            },
            child: const Text('Accept'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _declineCall(data['senderId']);
            },
            child: const Text('Decline'),
          ),
        ],
      ),
    );
  }

  void _declineCall(String senderId) {
    webSocketController.sendMessage(
      '',
      this.senderId.value,
      senderId,
      jsonEncode({"type": "decline"}),
    );
  }

  Future<void> createOffer(
    String receiverId, {
    required bool isVideoCall,
    String? mediaFilePath,
  }) async {
    try {
      debugPrint('Creating offer for receiver: $receiverId');
      currentMediaType.value = mediaFilePath != null
          ? 'file'
          : isVideoCall
              ? 'video'
              : 'audio';

      _peerConnection = await _createPeerConnection(receiverId);

      if (currentMediaType.value != 'file') {
        localStream = await _createMediaStream(isVideoCall);
        localStream?.getTracks().forEach((track) {
          debugPrint('Adding local track: ${track.label}');
          _peerConnection?.addTrack(track, localStream!);
        });
      }

      final offer = await _peerConnection!.createOffer();
      debugPrint('Created offer SDP: ${offer.sdp}');
      await _peerConnection!.setLocalDescription(offer);

      final roomId = messeageController.chatroomId.value;

      webSocketController.sendOffer(
        roomId,
        receiverId,
        offer.sdp ?? "v=0",
      );

      debugPrint('Sent offer to WebSocket for receiver: $receiverId');
    } catch (e) {
      debugPrint('Error creating offer: $e');
    }
  }

  Future<void> _handleOffer(Map<String, dynamic> data) async {
    try {
      debugPrint('Handling incoming offer with data: $data');
      final mediaType = data['mediaType'];
      currentMediaType.value = mediaType;

      _peerConnection = await _createPeerConnection(otherId.value);

      final offer = RTCSessionDescription(data['sdp'], 'offer');
      await _peerConnection!.setRemoteDescription(offer);
      debugPrint('Set remote description for received offer');

      if (mediaType != 'file') {
        localStream = await _createMediaStream(mediaType == 'video');
        localStream?.getTracks().forEach((track) {
          debugPrint('Adding local track for offer: ${track.label}');
          _peerConnection?.addTrack(track, localStream!);
        });
      }

      final answer = await _peerConnection!.createAnswer();
      debugPrint('Created answer SDP: ${answer.sdp}');
      await _peerConnection!.setLocalDescription(answer);

      webSocketController.sendOffer(
        data['roomId'],
        data['senderId'],
        answer.sdp ?? "v=0",
      );

      debugPrint('Sent answer to WebSocket for sender: ${data['senderId']}');
    } catch (e) {
      debugPrint('Error handling offer: $e');
    }
  }

  Future<void> _handleAnswer(Map<String, dynamic> data) async {
    try {
      debugPrint('Handling incoming answer: $data');
      final answer = RTCSessionDescription(data['sdp'], 'answer');
      await _peerConnection?.setRemoteDescription(answer);
      debugPrint('Set remote description for received answer');
    } catch (e) {
      debugPrint('Error handling answer: $e');
    }
  }

  Future<void> _handleCandidate(Map<String, dynamic> candidate) async {
    try {
      final rtcCandidate = RTCIceCandidate(
        candidate['candidate'],
        candidate['sdpMid'],
        candidate['sdpMLineIndex'],
      );
      await _peerConnection?.addCandidate(rtcCandidate);
    } catch (e) {
      debugPrint('Error handling candidate: $e');
    }
  }

  Future<RTCPeerConnection> _createPeerConnection(String reciverId) async {
    final config = {
      "iceServers": [
        {
          "urls": "stun:stun.l.google.com:19302",
        },
      ]
    };

    final peerConnection = await createPeerConnection(config);

    peerConnection.onTrack = (event) {
      if (event.streams.isNotEmpty) {
        remoteStream = event.streams[0];
        isInCall.value = true;
      }
    };

    peerConnection.onIceCandidate = (candidate) {
      // ignore: unnecessary_null_comparison
      if (candidate != null) {
        webSocketController.sendOffer(
          messeageController.chatroomId.value, // Use the current room ID
          reciverId, // The receiver ID (set appropriately)
          candidate.toMap()['candidate'] ?? '',
        );
      }
    };

    return peerConnection;
  }

  Future<MediaStream> _createMediaStream(bool isVideoCall) async {
    final constraints = {
      "audio": isAudioEnabled.value,
      "video": isVideoCall ? {"facingMode": "user"} : false,
    };

    return await rtc.mediaDevices.getUserMedia(constraints);
  }

  void endCall() {
    _peerConnection?.close();
    _peerConnection = null;
    localStream?.dispose();
    remoteStream?.dispose();
    isInCall.value = false;
    currentMediaType.value = '';
  }
}
