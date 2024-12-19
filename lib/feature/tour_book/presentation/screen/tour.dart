import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TourPage extends StatelessWidget {
  const TourPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse("https://unforgettablegetaway.com/"));
    return WebViewWidget(controller: controller);
  }
}
