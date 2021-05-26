import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

Widget appBar({
  @required Widget widget,
  bool centerTitle,
  List<Widget> actions,
  Widget leadingWidget,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: AppBar(
      backgroundColor: Colors.black,
      centerTitle: centerTitle ?? true,
      actions: actions,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: firstColor,
      ),
      title: widget,
      leading: leadingWidget,
    ),
  );
}
