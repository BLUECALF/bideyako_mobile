import 'package:bide_yako/loading.dart';
import 'package:bide_yako/utils/HelpfulFunctions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return wrapper(
      childWidget: GetMaterialApp(
        title: 'Bide Yako Web',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: wrapper( childWidget: LoadingPage()),
      ),
    );
  }
}
