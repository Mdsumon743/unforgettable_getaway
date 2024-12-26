import 'package:flutter/material.dart';
import 'package:unforgettable_getaway/core/utils/assetpath.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(Assetpath.logoOnboarding)
        ],
      ),
    );
  }
}
