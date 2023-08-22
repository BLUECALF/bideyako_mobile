import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebViewScreen(),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final String targetUrl = 'https://dev.bideyako.com/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView Demo'),
      ),
      body: WebView(
        initialUrl: targetUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
