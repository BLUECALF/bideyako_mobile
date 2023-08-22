
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String targetUrl = 'https://dev.bideyako.com/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: targetUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}