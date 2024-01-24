import 'package:bide_yako/loading.dart';
import 'package:bide_yako/utils/HelpfulFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(milliseconds: 300));
  // set screen orinetation to potrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return wrapper(
      childWidget: GetMaterialApp(
        title: 'Bide Yako Web',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: wrapper( childWidget: LoadingPage()),
      ),
    );
  }
}
