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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar(
        leadingWidget: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        widget: Text(""),
        centerTitle: true,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  "Question?",
                  style: boldStyle(
                      fontSize: Constant.xlargeFont + 4, color: greyColor),
                ),
                SizedBox(height: 10),
                Text(
                  "${commonQuestionItem.question}",
                  style:
                      boldStyle(fontSize: Constant.largeFont, color: greyColor),
                ),
              ],
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      colorFirstGrident,
                      colorSecondGrident,
                    ],
                            stops: [0.0, 1],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Answer",
                      style: boldStyle(
                          fontSize: Constant.xlargeFont + 4, color: greyColor),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding:  EdgeInsets.only(bottom: 80),
                      child: Text(
                        "${commonQuestionItem.answer}",
                        textAlign: TextAlign.center,
                        style: boldStyle(
                            fontSize: Constant.mediumFont, color: greyColor),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
