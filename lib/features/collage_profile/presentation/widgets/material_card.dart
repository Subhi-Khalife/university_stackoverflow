import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/core/widget/FontFamily.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';

class MaterialCard extends StatelessWidget {
  final String title;
  final String description;
  final int numberOfMaterial;
  const MaterialCard(
      {Key key, this.title, this.description, this.numberOfMaterial})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Card(
          color: Theme.of(context).scaffoldBackgroundColor,
          elevation: 9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.book_outlined,
                size: 35,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: boldStyle(
                          fontSize: Constant.mediumFont, color: Theme.of(context).accentColor)),
                  SizedBox(height: 4),
                  Text(
                      description.length > 18
                          ? description.substring(0, 18) + "..."
                          : description,
                      style: regularStyle(
                          fontSize: Constant.mediumFont,
                          color: Theme.of(context).hintColor))
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    numberOfMaterial.toString(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
