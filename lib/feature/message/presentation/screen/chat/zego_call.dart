import 'package:flutter/widgets.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCall extends StatelessWidget {
  final String name;
  final String id;
  const VideoCall({
    super.key,
    required this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 58036448,
      appSign:
          "dba7697d3b5a3848a64e0152a8f1cf1c265d2af3d54bd2bc7b269bbd61e77978",
      userID: id,
      userName: name,
      callID: '112233',
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}

class AudioCall extends StatelessWidget {
  final String name;
  final String id;
  const AudioCall({
    super.key,
    required this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 58036448,
      appSign:
          "dba7697d3b5a3848a64e0152a8f1cf1c265d2af3d54bd2bc7b269bbd61e77978",
      userID: id,
      userName: name,
      callID: '112233',
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}
