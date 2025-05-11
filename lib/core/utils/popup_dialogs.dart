import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PopupDialogs{

 static showToast(String msg){
    Fluttertoast.showToast(
      msg: msg,
      fontSize: 0.02.sh,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black.withOpacity(0.9),
    );
  }
}