import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constant.dart';
import 'font_style.dart';

class AppButton extends StatelessWidget {
  final Function function;
  final String name;
  final double elevationValue;
  final Color buttonColor;
  final Color fontColor;
  AppButton(
      {@required this.function,
      @required this.name,
      this.elevationValue = 0,
      this.buttonColor,
      this.fontColor});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        clipBehavior: Clip.antiAlias,
        onPressed: function,
        color: buttonColor??colorThemApp,
        elevation: elevationValue,
        height: 40,
        minWidth: MediaQuery.of(context).size.width * 0.4,
        child: Text(
          name,
          style: boldStyle(color:fontColor?? Colors.white, fontSize: Constant.mediumFont),
        ),
      ),
    );
  }
}
