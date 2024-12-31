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
      appID: 1986929935,
      appSign:
          "88b6e3057f73c2956905006a16c5dd075f22387fa9feee61fadb6b6135707614",
      userID: id,
      userName: name,
      callID: "1234",
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
      appID: 1986929935,
      appSign:
          "88b6e3057f73c2956905006a16c5dd075f22387fa9feee61fadb6b6135707614",
      userID: id,
      userName: name,
      callID: "1234",
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}
