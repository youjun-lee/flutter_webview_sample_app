import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tosspayments_widget_sdk_flutter/model/tosspayments_url.dart';
import 'package:url_launcher/url_launcher.dart';

class InAppWebViewScreen extends StatefulWidget {
  final String url;

  InAppWebViewScreen({required this.url});

  @override
  _InAppWebViewScreenState createState() => _InAppWebViewScreenState();
}

class _InAppWebViewScreenState extends State<InAppWebViewScreen> {
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('InAppWebView Example')),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.url)!),
        initialSettings: InAppWebViewSettings(
                useShouldOverrideUrlLoading: true,
                resourceCustomSchemes: ['intent', 'market']
        ),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onLoadStop: (controller, url) {},
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          var uri = navigationAction.request.url!;
          if (uri.scheme == 'http' || uri.scheme == 'https') {
            return NavigationActionPolicy.ALLOW;
          } else {
            tossPaymentsWebview(uri.toString());
            return NavigationActionPolicy.CANCEL;
          }
        },
        onLoadResourceWithCustomScheme: (controller, scheme) async {
          List<String> prefixes = ["intent", "market"];
          RegExp regExp = RegExp("^(${prefixes.map(RegExp.escape).join('|')})");
          if (regExp.hasMatch(scheme.url.rawValue)) {
            await _webViewController.stopLoading();
          }
        },
      ),
    );
  }

  bool shouldInterceptRequest(String url) {
    // URL을 분석하고 특정 조건에 따라 요청을 차단하거나 허용하는 로직
    // 예: 특정 URL 패턴이나 도메인을 체크
    return false; // 기본적으로는 차단하지 않음
  }
}

tossPaymentsWebview(url) async {
  final appScheme = ConvertUrl(url); // Intent URL을 앱 스킴 URL로 변환
  if (appScheme.isAppLink()) {
    // 앱 스킴 URL인지 확인
    await appScheme.launchApp(
        mode: LaunchMode.externalApplication); // 앱 설치 상태에 따라 앱 실행 또는 마켓으로 이동
    return true;
  }
  return false;
}
