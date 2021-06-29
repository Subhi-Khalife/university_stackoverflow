import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/core/entities/user.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/container_app_decoration.dart';
import 'package:university/core/widget/font_style.dart';

class NormalUserInformation extends StatelessWidget {
  final User userInfo;
  NormalUserInformation({this.userInfo});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
          elevation: 10,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 8, right: 8, bottom: 16, top: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    showInfo("email:", userInfo.email, context),
                    showInfo("Facebook:",userInfo.facebookUrl,context),
                    showInfo("Linkedin:",userInfo.linkedInUrl,context),
                    showInfo("Collage number",userInfo.collageNumber.toString(),context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showInfo(String title, String description, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16, top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: boldStyle(
                fontSize: Constant.mediumFont,
                color: Theme.of(context).accentColor),
          ),
          space(),
          Text(
            description,
            style: boldStyle(
                fontSize: Constant.smallFont,
                color: Theme.of(context).hintColor),
          ),
        ],
      ),
    );
  }

  Widget space() {
    return SizedBox(height: 8);
  }
}
