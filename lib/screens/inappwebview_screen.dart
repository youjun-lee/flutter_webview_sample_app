import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tosspayments_widget_sdk_flutter/model/tosspayments_url.dart';


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
      appBar: AppBar(title: const Text('InAppWebView Example')),  // 앱의 상단바 설정
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(widget.url)!), // 초기에 로드할 URL 설정 (필요시 텍스트 입력)
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
          if (uri.scheme == 'http' || uri.scheme == 'https') { // 표준 웹 URL 체크
            return NavigationActionPolicy.ALLOW;
          } else { // 그 외의 경우에는 tossPaymentsWebvew 함수로 검증
            tossPaymentsWebview(uri.toString());
            return NavigationActionPolicy.CANCEL;
          }
        },
        onLoadResourceWithCustomScheme: (controller, scheme) async {
          List<String> prefixes = ["intent", "market"]; // 커스텀 스킴 프리픽스
          RegExp regExp = RegExp("^(${prefixes.map(RegExp.escape).join('|')})");

          if (regExp.hasMatch(scheme.url.rawValue)) {
            await _webViewController.stopLoading(); // 일치하는 경우 로딩 중단
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

//tosspayments_widget_sdk_flutter 내 외부 카드사 앱 띄울 수 있도록 URL 변경하는 함수 실행
tossPaymentsWebview(url) async {
  final appScheme = ConvertUrl(url); // Intent URL을 앱 스킴 URL로 변환
  if (appScheme.isAppLink()) {
    // 앱 스킴 URL인지 확인
    await appScheme.launchApp( mode: LaunchMode.externalApplication); // 앱 설치 상태에 따라 앱 실행 또는 마켓으로 이동
    return true;
  }
  return false;
}
