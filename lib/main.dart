import 'package:bide_yako/loading.dart';
import 'package:bide_yako/utils/HelpfulFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bide Yako Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: wrapper( childWidget: LoadingPage()),
    );
  }
}
