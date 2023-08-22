import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String targetUrl = 'https://dev.bideyako.com/';
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: targetUrl,
              javascriptMode: JavascriptMode.unrestricted,
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
            isLoading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Container(), // This container will be empty when the WebView finishes loading
          ],
        ),
      ),
    );
  }
}
