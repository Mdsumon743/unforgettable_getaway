import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:unforgettable_getaway/feature/message/controller/audio_video_controller.dart';

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CallController callController =
        CallController(); // Initialize directly without GetX

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Video Call"),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          if (callController.remoteStream != null)
            RTCVideoView(
              RTCVideoRenderer()
                ..initialize()
                ..srcObject = callController.remoteStream,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            )
          else
            const Center(
              child: Text(
                "Waiting for another participant...",
                style: TextStyle(color: Colors.white),
              ),
            ),

          // Local video stream (small draggable overlay)
          if (callController.localStream != null)
            Positioned(
              top: 20,
              right: 20,
              child: Draggable(
                feedback: Container(
                  width: 120.w,
                  height: 160.h,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: RTCVideoView(
                    RTCVideoRenderer()
                      ..initialize()
                      ..srcObject = callController.localStream,
                    mirror: true,
                  ),
                ),
                childWhenDragging: const SizedBox(),
                child: Container(
                  width: 120.w,
                  height: 160.h,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: RTCVideoView(
                    RTCVideoRenderer()
                      ..initialize()
                      ..srcObject = callController.localStream,
                    mirror: true,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          callController.endCall();
          Navigator.pop(context);
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.call_end),
      ),
    );
  }
}
