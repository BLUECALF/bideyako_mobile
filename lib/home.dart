import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String targetUrl = 'https://dev.bideyako.com/';
  bool isLoading = true;
  final _webViewController = Completer<WebViewController>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? lastBackPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            final controller = await _webViewController.future;
            if (await controller.canGoBack()) {
              controller.goBack();
              return Future.value(false);
            }

            final now = DateTime.now();
            if (lastBackPressed == null || now.difference(lastBackPressed!) > Duration(seconds: 2)) {
              lastBackPressed = now;
              final snackBar = SnackBar(content: Text('Press back again to exit'));
              _scaffoldKey.currentState!.showSnackBar(snackBar);
              return Future.value(false);
            }
            return Future.value(true);
          },
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
                onWebViewCreated: (controller) {
                  _webViewController.complete(controller);
                },
              ),
              isLoading
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
