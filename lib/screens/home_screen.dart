import 'package:flutter/material.dart';
import 'webview_flutter_screen.dart'; // 웹뷰 스크린을 임포트합니다

class HomeScreen extends StatelessWidget {
  final TextEditingController urlController = TextEditingController(text: 'http://52.78.198.128/sample/');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,  // AppBar의 배경색을 파란색으로 설정
        foregroundColor: Colors.white,  // AppBar의 전방 색상(텍스트)을 흰색으로 설정
        title: Text('Toss payments Webview Sample'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: urlController,
                decoration: InputDecoration(
                  labelText: 'URL',
                  border: OutlineInputBorder(),
                  hintText: 'Enter a URL',
                ),
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewFlutterScreen(url: urlController.text),
                    ),
                  );
                  print('webview_flutter Launch'); // 추후 기능 추가 예정
                },
                child: Text('webview_flutter Launch'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    // 모서리를 사각형으로 설정
                    borderRadius: BorderRadius.zero,
                  ), // 버튼 텍스트 색상을 흰색으로 설정
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // inappwebview 화면으로 이동
                  print('inappwebview Launch'); // 추후 기능 추가 예정
                },
                child: Text('inappwebview Launch'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    // 모서리를 사각형으로 설정
                    borderRadius: BorderRadius.zero,
                  ), // 버튼 텍스트 색상을 흰색으로 설정
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
