import 'package:flutter/material.dart';
import 'package:unforgettable_getaway/core/utils/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TourPage extends StatefulWidget {
  const TourPage({super.key});

  @override
  _TourPageState createState() => _TourPageState();
}

class _TourPageState extends State<TourPage> {
  late WebViewController _controller;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://unforgettablegetaway.com/"));
  }

  void _goBack() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkBrown,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: _goBack,
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller
              ..setNavigationDelegate(
                NavigationDelegate(
                  onPageStarted: (url) {
                    setState(() {
                      isLoading = true;
                    });
                  },
                  onPageFinished: (url) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
              ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.yellowColor,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
