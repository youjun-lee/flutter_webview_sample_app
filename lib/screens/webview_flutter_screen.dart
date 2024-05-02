import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:tosspayments_widget_sdk_flutter/model/tosspayments_url.dart';

class WebViewFlutterScreen extends StatefulWidget {
  final String url;
  WebViewFlutterScreen({required this.url});

  @override
  State<WebViewFlutterScreen> createState() => _WebViewFlutterScreen();
}

class _WebViewFlutterScreen extends State<WebViewFlutterScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https') ||
                request.url.startsWith("http")) {
              return NavigationDecision.navigate;
            }
            tossPaymentsWebview(request.url);
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: WebViewWidget(controller: _controller),
    );
  }
}

tossPaymentsWebview(url) {
  final appScheme = ConvertUrl(url); // Intent URL을 앱 스킴 URL로 변환
  if (appScheme.isAppLink()) {
    // 앱 스킴 URL인지 확인
    appScheme.launchApp(mode: LaunchMode.externalApplication); // 앱 설치 상태에 따라 앱 실행 또는 마켓으로 이동
    return NavigationDecision.prevent;
  }
}
