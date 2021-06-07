

import 'package:flutter/material.dart';


class LoadingDialog{

  var dialog;

  LoadingDialog( BuildContext context ){
    print("loading");
    dialog=WillPopScope(
      onWillPop: (){
        return null;
      },

      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(backgroundColor:Color(0xff9574bb),
            strokeWidth: 2,
            valueColor:  AlwaysStoppedAnimation<Color>(Colors.white70),
          ),
        ),
      ),
    );

  }

  void show(BuildContext context) {
    showDialog(context: context, builder: (x) => dialog,barrierDismissible: false);
//    Future.delayed(const Duration(seconds: 2), () {
//      showMessage('no response ', 2);
//      Navigator.pop(context);
////      setState(() {
////        // Here you can write your code for open new view
////      });
//    });

  }

  void dismiss(BuildContext context) {
    Navigator.pop(context);
  }

}