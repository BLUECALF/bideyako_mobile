import 'package:bide_yako/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    goToSplash(context);
    return Scaffold(
      body:Column(
        children: [
          SizedBox(height: 400.h,),
          SizedBox(
              width: 320.w,
              height: 110.h,
              child: Image.asset("assets/images/bid-logo.png")),
          SizedBox(height: 300.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("From ",style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 25.sp,
                  letterSpacing: (7/100 *25).w,
                  fontWeight: FontWeight.w300
              ),),
              Text("Bide Yako",style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 25.sp,
                  letterSpacing: (7/100 * 25).w,
                  fontWeight: FontWeight.bold
              ),),
            ],
          )
        ],
      ),
    );
  }
  void goToSplash(BuildContext context) async
  {
    await Future.delayed(Duration(milliseconds: 3000));

    Get.off(() => Home());
  }
}
