import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Toss payments Webview Sample'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: 'http://52.78.198.128/sample/', // 입력 필드의 기본값 설정
                  decoration: InputDecoration(
                    labelText: 'URL',
                    border: OutlineInputBorder(),
                    hintText: 'Enter a URL',
                  ),
                ),
              ),
              SizedBox(height: 50), // 입력 필드와 버튼 사이의 간격
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // 여기에 webview_flutter 런칭 코드를 추가하세요.
                    print('Launching webview_flutter');
                  },
                  child: Text('webview_flutter Launch'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // 버튼의 최소 크기 설정
                  ),
                ),
              ),
              SizedBox(height: 20), // 첫 번째 버튼과 두 번째 버튼 사이의 간격
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // 여기에 inappwebview 런칭 코드를 추가하세요.
                    print('Launching inappwebview');
                  },
                  child: Text('inappwebview Launch'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // 버튼의 최소 크기 설정
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
