// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';

// class AudioVideoController extends GetxController {
//   static final String appId = "4d4e630ac26c44b1bb95088bb4e47848"; // Add your Agora App ID here
//   static final String token = "007eJxTYIi5cVJ4p2rLb8b3Tmt3dF15EHCamUFwz4WaS90d34+UbFVVYDBJMUk1MzZITDYySzYxSTJMSrI0NbCwSEoySTUxtzCx2KqwPb0hkJGhNzeAhZEBAkF8FoaS1OISBgYA0vUg5w=="; // Add your Agora Token here
//   static final String channelName = "test";

//   late RtcEngine engine;
//   var localUserJoined = false.obs;
//   var remoteUid = Rxn<int>();

//   @override
//   void onInit() {
//     super.onInit();
//     _initAgora();
//   }

//   Future<void> _initAgora() async {
//     // Retrieve permissions
//     await [Permission.microphone, Permission.camera].request();

//     // Create the engine
//     engine = createAgoraRtcEngine();
//     await engine.initialize(RtcEngineContext(appId: appId));

//     engine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection connection, int uid) {
//           debugPrint("local user $uid joined");
//           localUserJoined.value = true;
//         },
//         onUserJoined: (RtcConnection connection, int uid, int elapsed) {
//           debugPrint("remote user $uid joined");
//           remoteUid.value = uid;
//         },
//         onUserOffline:
//             (RtcConnection connection, int uid, UserOfflineReasonType reason) {
//           debugPrint("remote user $uid left channel");
//           remoteUid.value = null;
//         },
//       ),
//     );

//     await engine.enableVideo();
//     await engine.startPreview();
//     await engine.joinChannel(
//       token: token,
//       channelId: channelName,
//       uid: 0,
//       options: ChannelMediaOptions(),
//     );
//   }

//   @override
//   void onClose() {
//     engine.leaveChannel();
//     engine.release();
//     super.onClose();
//   }
// }
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CallingController extends GetxController {
  final String appId = "4d4e630ac26c44b1bb95088bb4e47848";
  final String channel = "up_test";
  final String token =
      "007eJxTYLCNybqofW/1NNus+M0Lj1UaiSZHzzsvr3sySWFDa5NfxxcFBpMUk1QzY4PEZCOzZBOTJMOkJEtTAwuLpCSTVBNzCxMLN98d6Q2BjAxpGzcxMEIhiM/OUFoQX5JaXMLAAACFMSBC";

  late RtcEngine engine;
  var remoteUid = Rx<int?>(null);
  var localUserJoined = false.obs;
  var isMuted = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initAgora();
    joinChannel();
  }

  Future<void> _initAgora() async {
    await _requestPermissions();
    engine = createAgoraRtcEngine();
    await engine.initialize(
      RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined");
          localUserJoined.value = true;
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          this.remoteUid.value = remoteUid;
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left");
          this.remoteUid.value = null;
        },
      ),
    );
    await engine.enableVideo();
    await engine.startPreview();
  }

  Future<void> _requestPermissions() async {
    await [Permission.microphone, Permission.camera].request();
  }

  Future<void> joinChannel() async {
    await engine.joinChannel(
      token: token,
      channelId: channel,
      options: const ChannelMediaOptions(
        autoSubscribeVideo: true,
        autoSubscribeAudio: true,
        publishCameraTrack: true,
        publishMicrophoneTrack: true,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
      uid: 0,
    );
    debugPrint("Room Joined =============<><><><><><>");
  }

  Future<void> leaveChannel() async {
    await engine.leaveChannel();
    remoteUid.value = null;
    localUserJoined.value = false;
  }

  void toggleMute() {
    isMuted.value = !isMuted.value;
    engine.muteLocalAudioStream(isMuted.value);
  }

  void switchCamera() {
    engine.switchCamera();
  }

  @override
  void onClose() {
    engine.release();
    super.onClose();
  }
}
