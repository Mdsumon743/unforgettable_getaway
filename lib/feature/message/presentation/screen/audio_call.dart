import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/audio_video_controller.dart';

class AudioCallScreen extends StatelessWidget {
  final CallController callController = Get.put(CallController());
  final String userName;

  AudioCallScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Audio Call with $userName"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              userName,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 40),
            Obx(() {
              return IconButton(
                icon: Icon(
                  callController.isAudioEnabled.value
                      ? Icons.mic
                      : Icons.mic_off,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  callController.isAudioEnabled.value =
                      !callController.isAudioEnabled.value;
                },
              );
            }),
          ],
        ),
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
