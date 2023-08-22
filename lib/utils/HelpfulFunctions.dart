import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

String getNameInitials(full_name) {
  if (full_name == null) {
    return "";
  }
  List<String> names = full_name.split(" ");
  String initials = "";
  int numWords = 2;

  numWords = names.length;
  for (var i = 0; i < numWords; i++) {
    if (names[i] == "") {
      initials += "";
    } else {
      initials += '${names[i].substring(0, 1)}';
      if (initials.length == 2) {
        return initials;
      }
    }
  }
  return initials;
}

String getLastName({required String fullName}) {
  List<String> nameList = fullName.split(" ");
  print("name list is $nameList");
  var lastname = nameList[nameList.length - 1];
  if (lastname == " " || lastname == "" || lastname == "  ") {
    return nameList[nameList.length - 2];
  } else
    return nameList[nameList.length - 1];
}

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

