import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constant.dart';
import 'font_style.dart';

class BlocErrorScreen extends StatelessWidget {
  final Function function;
  final String title;
  BlocErrorScreen({this.function, this.title = "Error Happened try again"});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        child: Center(
          child: Text(
            title,
            style:
                regularStyle(fontSize: Constant.mediumFont, color: firstColor),
          ),
        ),
      ),
    );
  }
}
