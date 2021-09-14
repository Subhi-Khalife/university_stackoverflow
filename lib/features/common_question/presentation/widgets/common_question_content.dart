import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/core/widget/container_app_decoration.dart';

import '../../../../core/entities/common_question.dart';
import '../../../../core/widget/app_bar.dart';
import '../../../../core/widget/colors.dart';
import '../../../../core/widget/constant.dart';
import '../../../../core/widget/font_style.dart';

class CommonQuestionContent extends StatelessWidget {
  final CommonQuestion commonQuestionItem;
  CommonQuestionContent({@required this.commonQuestionItem});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    "Question?",
                    style: boldStyle(
                        fontSize: Constant.xlargeFont + 4, color: Theme.of(context).hintColor),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${commonQuestionItem.question}",
                    style: boldStyle(
                      fontSize: Constant.largeFont,
                      color: Theme.of(context).hintColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 40),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: containerDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16, bottom: 8.0),
                    child: Column(
                      children: [
                        Text(
                          "Answer",
                          style: boldStyle(
                              fontSize: Constant.xlargeFont + 4,
                              color: Theme.of(context).hintColor),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: EdgeInsets.only(bottom: 80),
                          child: Text(
                            "${commonQuestionItem.answer}",
                            textAlign: TextAlign.center,
                            style: boldStyle(
                                fontSize: Constant.mediumFont, color: Theme.of(context).hintColor),
                          ),
                        ),
                      ],
                    ),
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
