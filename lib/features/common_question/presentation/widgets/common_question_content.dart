import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:university/core/entities/common_question.dart';
import 'package:university/core/widget/FontFamily.dart';
import 'package:university/core/widget/app_bar.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';

class CommonQuestionContent extends StatelessWidget {
  final CommonQuestion commonQuestionItem;
  CommonQuestionContent({@required this.commonQuestionItem});
  @override
  Widget build(BuildContext context) {
    // AppBarRestaurant appBar = AppBarRestaurant(
    //   context: context,
    //   title: "",
    //   appColor: colorThemApp,
    //   centerTitle: true,
    //   backIcon: false,

    // );
    return Scaffold(
      appBar: appBar(
        leadingWidget: IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        widget: Text(
          "Question Contenet",
          style: boldStyle(fontSize: Constant.largeFont, color: firstColor),
        ),
        centerTitle: true,
        actions: [],
      ),
      body: Card(
        elevation: 4,
        color: Colors.grey.shade100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16, bottom: 12, left: 6, right: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('yyyy-MM-dd – kk:mm')
                        .format(commonQuestionItem.createdAt),
                    style: regularStyle(
                        fontSize: Constant.mediumFont, color: firstColor),
                  ),
                  Text(
                    "Aleppo university",
                    style: regularStyle(
                        fontSize: Constant.mediumFont, color: secondColor),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12, bottom: 12, left: 6, right: 6),
              child: Text(
                commonQuestionItem.answer,
                style: regularStyle(
                    fontSize: Constant.mediumFont, color: firstColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
