// import 'package:flutter/widgets.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// class VideoCall extends StatelessWidget {
//   final String name;
//   final String id;
//   const VideoCall({
//     super.key,
//     required this.name,
//     required this.id,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ZegoUIKitPrebuiltCall(
//       appID: 58036448,
//       appSign:
//           "dba7697d3b5a3848a64e0152a8f1cf1c265d2af3d54bd2bc7b269bbd61e77978",
//       userID: id,
//       userName: name,
//       callID: '112233',
//       config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
//     );
//   }
// }

// class AudioCall extends StatelessWidget {
//   final String name;
//   final String id;
//   const AudioCall({
//     super.key,
//     required this.name,
//     required this.id,
//   });

// ignore_for_file: library_private_types_in_public_api

//   @override
//   Widget build(BuildContext context) {
//     return ZegoUIKitPrebuiltCall(
//       appID: 58036448,
//       appSign:
//           "dba7697d3b5a3848a64e0152a8f1cf1c265d2af3d54bd2bc7b269bbd61e77978",
//       userID: id,
//       userName: name,
//       callID: '112233',
//       config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
//     );
//   }
// }
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import '../../../controller/agora_call_controller.dart';

class CallingPage extends StatelessWidget {
  const CallingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CallingController controller = Get.put(CallingController());
    Timer(
      Duration(seconds: 2),
      () {
        controller.joinChannel();
      },
    );

    return Scaffold(
      body: Stack(
        children: [
          // Remote User Video
          Obx(() => controller.remoteUid.value != null
              ? AgoraVideoView(
                  controller: VideoViewController.remote(
                    rtcEngine: controller.engine,
                    canvas: VideoCanvas(uid: controller.remoteUid.value!),
                    connection: RtcConnection(channelId: controller.channel),
                  ),
                )
              : Center(
                  child: Text("Video Calling",
                      style: TextStyle(fontSize: 18.sp)))),

          // Local User Video (Small Preview)
          Positioned(
            top: 20,
            right: 20,
            child: Obx(() => controller.localUserJoined.value
                ? SizedBox(
                    width: 120.w,
                    height: 160.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: controller.engine,
                          canvas: const VideoCanvas(
                              uid: 0,
                              renderMode: RenderModeType.renderModeHidden),
                        ),
                      ),
                    ),
                  )
                : const SizedBox()),
          ),

          // Controls
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.r, horizontal: 20.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () {
                      controller.leaveChannel();
                      Get.back();
                    },
                    child: const Icon(Icons.call_end, color: Colors.white),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.blue,
                    onPressed: controller.toggleMute,
                    child: Obx(() => Icon(
                          controller.isMuted.value ? Icons.mic_off : Icons.mic,
                          color: Colors.white,
                        )),
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.green,
                    onPressed: controller.switchCamera,
                    child: const Icon(Icons.switch_camera, color: Colors.white),
                  ),
                  // FloatingActionButton(
                  //   backgroundColor: Colors.green,
                  //   onPressed: controller.joinChannel,
                  //   child: const Icon(Icons.add, color: Colors.white),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
