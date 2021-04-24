import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/entities/common_question.dart';
import '../../../../core/widget/colors.dart';
import '../../../../core/widget/constant.dart';
import '../../../../core/widget/font_style.dart';
import 'common_question_content.dart';

class CommonQuestionView extends StatelessWidget {
  final CommonQuestion commonQuestionItem;
  CommonQuestionView({this.commonQuestionItem});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6, right: 6),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CommonQuestionContent(
                  commonQuestionItem: commonQuestionItem)));
        },
        child: Card(
          elevation: 4,color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 16, bottom: 12, left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('yyyy-MM-dd – kk:mm')
                              .format(commonQuestionItem.createdAt),
                          style: regularStyle(
                              fontSize: Constant.mediumFont, color: secondColor),
                        ),
                        SizedBox(height: 8),
                        Text(
                          DateFormat('kk:mm')
                              .format(commonQuestionItem.createdAt),
                          style: regularStyle(
                              fontSize: Constant.mediumFont, color: secondColor),
                        )
                      ],
                    ),
                    Text(
                      "Aleppo university",
                      style: regularStyle(
                          fontSize: Constant.mediumFont, color: firstColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 12, bottom: 12, left: 6, right: 6),
                child: Text(
                  commonQuestionItem.question,
                  style: regularStyle(
                      fontSize: Constant.mediumFont, color: firstColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
