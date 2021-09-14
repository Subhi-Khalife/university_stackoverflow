import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/features/collage_profile/data/models/collage_profile.dart';

class SimpleCard extends StatelessWidget {
  final String name;
  final int id;
  SimpleCard({@required this.name, @required this.id});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 75,
        child: Card(
          elevation: 9,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
              child: Text(
            name,
            style: boldStyle(
                fontSize: Constant.mediumFont,
                color: Theme.of(context).hintColor),
          )),
        ),
      ),
    );
  }
}
