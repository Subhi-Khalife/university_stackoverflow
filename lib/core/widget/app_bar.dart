import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appBar(
    {@required Widget widget,
    bool centerTitle,
    List<Widget> actions,
    Widget leadingWidget,
    Widget bottom,
    @required BuildContext context}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),

    child: AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: centerTitle ?? true,
      actions: actions,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Theme.of(context).hintColor,
      ),
      title: widget,
      leading: leadingWidget,
      bottom: bottom,
    ),
  );
}
