import 'dart:async';
import 'package:bide_yako/styles/colors.dart';
import 'package:bide_yako/utils/HelpfulFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
      baseUrl + "users/settings/1",
      baseUrl + "buybids",
      baseUrl + "help/how_it_works",
      baseUrl + "users/settings/4",
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
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                onWebResourceError: (error) async {
                  _handleError(await _webViewController.future, error.failingUrl!, error.description);
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
            label: 'Auctions',
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.settings, 1, _currentIndex),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.shopping_cart_outlined, 2, _currentIndex),
            label: 'Buy Bids',
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.contact_support_outlined, 3, _currentIndex),
            label: 'Help',
          ),
          BottomNavigationBarItem(
            icon: buildIcon(Icons.notifications_active_outlined, 4, _currentIndex),
            label: 'Notification',
          ),
        ],
      ),
    );
  }

  /// handle http errors
  void _handleError(WebViewController controller, String url, String error) {
    if (error == 'net::ERR_NAME_NOT_RESOLVED' || error == 'net::ERR_ADDRESS_UNREACHABLE') {
      _showGetXDialog('No internet connection,Open WiFi or Data',controller,url);
    } else if (error.contains('404')) {
      _showGetXDialog('Page not found',controller,url);
    } else if (error.contains('timeout')) {
      _showGetXDialog('Connection timed out',controller,url);
    } else {
      _showGetXDialog("Something Went Wrong !,Check Your Internet and Retry",controller,url);
    }
    controller.loadUrl('about:blank'); // Clear the webview
  }


  /// getx dialog
  void _showGetXDialog(String message,WebViewController controller,url) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message, textAlign: TextAlign.center),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  controller.loadUrl(url);
                  Get.back();
                  setState(() {
                    isLoading = false;
                  });
                }, // Close the dialog
                child: Text('Refresh'),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Make the dialog undismissible
    );
  }
}