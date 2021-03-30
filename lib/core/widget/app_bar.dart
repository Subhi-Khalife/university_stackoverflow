import 'package:flutter/material.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';

class AppBarRestaurant {
  List<Widget> actions;
  bool centerTitle;
  String title;
  Color appColor;
  bool backIcon;
  BuildContext context;
  AppBar custom;
  AppBarRestaurant(
      {@required this.context,
      this.actions,
      this.centerTitle,
      this.title,
      this.appColor,
      this.backIcon}) {
    custom = AppBar(
      elevation: 0.0,
      actions: actions ?? [],
      automaticallyImplyLeading: false,
      title: Transform.translate(
          offset: Offset(backIcon ? -25 : 0, 0),
          child: Text(
            title ?? "",
            style: boldStyle(fontSize: Constant.largeFont, color: Colors.white),
          )),
      centerTitle: centerTitle ?? false,
      backgroundColor: appColor ?? colorWhite,
      leading: backIcon ?? false
          ? Transform.translate(
              offset: Offset(-5, 0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 17,
                  color: firstColor,
                ),
              ),
            )
          : null,
    );
  }
}
