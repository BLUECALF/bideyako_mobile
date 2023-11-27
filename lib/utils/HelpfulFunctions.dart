import 'dart:io';
import 'package:bide_yako/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<bool> hasInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}

bool is_square_screen({required double width, required double height}) {
  double ratio = height / width;
  if (ratio >= 1.5) {
    return false;
  } else
    return true;
}


/// wrapper to make widgets interactive

Widget wrapper({required Widget childWidget}) {
  // set screen orinetation to potrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  return ScreenUtilInit(
    designSize: is_square_screen(width: Get.width, height: Get.height)
        ? Size(Get.width, 926)
        : Size(428, 926),
    builder: (context, child) => childWidget,
  );
}

Widget buildIcon(IconData icon, int currentIndex,int selectedIndex) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.sp),
          shape: BoxShape.rectangle,
          color: selectedIndex == currentIndex ? color_green_dark : color_white,
        ),
        padding: EdgeInsets.all(10.sp), // Adjust the padding as needed
        child: Icon(
          icon,
          color: selectedIndex == currentIndex ? Colors.white : Colors.black,
        ),
      ),
    ],
  );
}