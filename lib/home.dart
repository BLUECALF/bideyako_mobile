import 'dart:async';
import 'package:bide_yako/styles/colors.dart';
import 'package:bide_yako/utils/HelpfulFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String baseUrl = "https://dev.bideyako.com/";
  List<String> _urls = [];

  int _currentIndex = 0;
  bool isLoading = true;
  final _webViewController = Completer<WebViewController>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? lastBackPressed;

  @override
  Widget build(BuildContext context) {
    _urls = [
      baseUrl,
      baseUrl + "buybids",
      baseUrl + "users/settings/7",
      baseUrl + "users/settings/6",
      baseUrl + "users/settings/1",
    ];
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
                initialUrl: _urls[_currentIndex],
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
                child: CircularProgressIndicator(
                  color: color_green_dark,
                  strokeWidth: 2.sp,
                ),
              )
                  : Container(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) async {
          setState(() {
            _currentIndex = index;
          });
          final controller = await _webViewController.future;
          controller.loadUrl(_urls[_currentIndex]);
        },
        backgroundColor: color_white,
        selectedItemColor: Colors.black, // Color for the selected tab
        unselectedItemColor: Colors.black, // Color for unselected tabs
        elevation: 0, // Elevation of the BottomNavigationBar
        selectedFontSize: 12.0.sp, // Font size for the selected tab label
        unselectedFontSize: 12.0.sp, // Font size for unselected tab labels
        type: BottomNavigationBarType.fixed, // Ensure that labels are shown for all tabs
        items: [
          BottomNavigationBarItem(
            icon: buildIcon(Icons.home_outlined, 0, _currentIndex),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.shopping_cart_outlined, 1, _currentIndex),
            label: 'Buy Bids',
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.emoji_events_outlined, 2, _currentIndex),
            label: 'Won Auctions',
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.receipt_long, 3, _currentIndex),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.person_outline, 4, _currentIndex),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}