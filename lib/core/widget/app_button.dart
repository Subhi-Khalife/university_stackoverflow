import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constant.dart';
import 'font_style.dart';

class AppButton extends StatelessWidget {
  final Function function;
  final String name;
  AppButton({@required this.function, @required this.name});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        clipBehavior: Clip.antiAlias,
        onPressed: function,
        color: colorThemApp,
        minWidth: MediaQuery.of(context).size.width * 0.75,
        child: Text(
          name,
          style: boldStyle(color: Colors.white, fontSize: Constant.mediumFont),
        ),
      ),
    );
  }
}