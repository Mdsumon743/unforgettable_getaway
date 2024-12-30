import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:unforgettable_getaway/core/helper/shared_prefarences_helper.dart';
import 'package:unforgettable_getaway/feature/message/controller/web_soket_controller.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart' as rtc;

class CallController extends GetxController {
  SharedPreferencesHelper preferencesHelper = SharedPreferencesHelper();
  final WebSoketController webSocketController = Get.put(WebSoketController());
  RxString senderId = "".obs;
  RTCPeerConnection? _peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;

  var isAudioEnabled = true.obs;
  var isVideoEnabled = true.obs;
  var isInCall = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserId();
    webSocketController.setOnMessageReceived(_handleSignalingMessage);
  }

  Future<void> loadUserId() async {
    await preferencesHelper.init();
    String? userid = preferencesHelper.getString("userId");
    senderId.value = userid ?? "";
  }

  /// Handle incoming WebSocket signaling messages
  void _handleSignalingMessage(String message) async {
    final data = jsonDecode(message);
    final type = data['type'];

    switch (type) {
      case 'offer':
        await _handleOffer(data);
        break;
      case 'answer':
        await _handleAnswer(data);
        break;
      case 'candidate':
        await _handleCandidate(data['candidate']);
        break;
      default:
        debugPrint('Unknown signaling message type: $type');
    }
  }

  /// Create and send an offer
  Future<void> createOffer(String receiverId) async {
    try {
      _peerConnection = await _createPeerConnection();
      localStream = await _createMediaStream();

      localStream?.getTracks().forEach((track) {
        _peerConnection?.addTrack(track, localStream!);
      });

      final offer = await _peerConnection!.createOffer();
      await _peerConnection!.setLocalDescription(offer);

      debugPrint("========SDP Offer===========: ${offer.sdp}"); 

      webSocketController.sendMessage(
        '',
        senderId.value,
        receiverId,
        jsonEncode({"type": "offer", "sdp": offer.sdp}),
      );
    } catch (e) {
      debugPrint('Error creating offer: $e');
    }
  }

  /// Handle incoming offer
  Future<void> _handleOffer(Map<String, dynamic> data) async {
    try {
      _peerConnection = await _createPeerConnection();

      final offer = RTCSessionDescription(data['offer']['sdp'], 'offer');
      await _peerConnection!.setRemoteDescription(offer);

      localStream = await _createMediaStream();
      localStream?.getTracks().forEach((track) {
        _peerConnection?.addTrack(track, localStream!);
      });

      final answer = await _peerConnection!.createAnswer();
      await _peerConnection!.setLocalDescription(answer);

      debugPrint("SDP Answer: ${answer.sdp}"); // Print SDP answer

      webSocketController.sendMessage(
        '',
        senderId.value,
        data['senderId'],
        jsonEncode({"type": "answer", "sdp": answer.sdp}),
      );
    } catch (e) {
      debugPrint('Error handling offer: $e');
    }
  }

  /// Handle incoming answer
  Future<void> _handleAnswer(Map<String, dynamic> data) async {
    try {
      final answer = RTCSessionDescription(data['sdp'], 'answer');
      await _peerConnection?.setRemoteDescription(answer);
    } catch (e) {
      debugPrint('Error handling answer: $e');
    }
  }

  /// Handle incoming ICE candidate
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

  /// Create a WebRTC PeerConnection
  Future<RTCPeerConnection> _createPeerConnection() async {
    final config = {
      "iceServers": [
        {
          "urls": "stun:stun.l.google.com:19302", // STUN server
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
      if (candidate != null) {
        webSocketController.sendMessage(
          '',
          senderId.value,
          '',
          jsonEncode({"type": "candidate", "candidate": candidate.toMap()}),
        );
      }
    };

    return peerConnection;
  }

  /// Create a local media stream
  Future<MediaStream> _createMediaStream() async {
    final constraints = {
      "audio": isAudioEnabled.value,
      "video": isVideoEnabled.value ? {"facingMode": "user"} : false,
    };

    return await rtc.navigator.mediaDevices.getUserMedia(constraints);
  }

  /// End the call and clean up resources
  void endCall() {
    _peerConnection?.close();
    _peerConnection = null;
    localStream?.dispose();
    remoteStream?.dispose();
    isInCall.value = false;
  }
}
