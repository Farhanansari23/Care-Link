import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessageUtils {
  void showToastMessage(String message, [ToastGravity? gravity, Color? color]) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity ?? ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: color ?? Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
      webShowClose: true,
    );
  }
}
