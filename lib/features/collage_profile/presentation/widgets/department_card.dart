import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/features/collage_profile/data/models/collage_profile.dart';

class DepartmentCard extends StatelessWidget {
  final String name;
  final int id;
  DepartmentCard({@required this.name, @required this.id});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 75,
        child: Card(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
          elevation: 9,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  name,
                  style: boldStyle(
                      fontSize: Constant.mediumFont,
                      color: Theme.of(context).hintColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Icon(
                  Icons.book_outlined,
                  color: Theme.of(context).hintColor,
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
