import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:university/core/widget/colors.dart';

showMessage(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.values[1],
      timeInSecForIosWeb: 1,
      backgroundColor:colorThemApp,
      textColor: Colors.white,
      fontSize: 16.0);
}
