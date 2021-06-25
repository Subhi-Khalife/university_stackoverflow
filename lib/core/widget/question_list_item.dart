import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/features/general_question/data/models/general_questions_model.dart';

class QuestionListItem extends StatelessWidget {
  final QuestionListItemParam questionListItemParam;
  QuestionListItem({@required this.questionListItemParam});
  final List<String> _materialName = ['math', "linear algibra", "algorithm"];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12, right: 8, left: 8),
      child: InkWell(
          onTap: () {
            questionListItemParam.navigatorFunction();
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showTopInfo(questionListItemParam),
                  SizedBox(height: 8),
                  Text(
                    questionListItemParam.title,
                    style: boldStyle(
                        fontSize: Constant.largeFont, color: Theme.of(context).primaryColor),
                  ),
                  Html(
                    data: questionListItemParam.description.length > 20
                        ? questionListItemParam.description.substring(0, 20)
                        : questionListItemParam.description,
                  ),
                  SizedBox(height: 4),
                  showTags(),
                  Divider(),
                  showReaction(questionListItemParam),
                  SizedBox(height: 8),
                ],
              ),
            ),
          )),
    );
  }

  Widget showReaction(QuestionListItemParam item) {
    return Padding(
      padding: EdgeInsets.only(right: 6, left: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text(item.reactsLength.toString(),
                  style: boldStyle(
                    fontSize: Constant.mediumFont,
                    color: firstColor,
                  )),
              SizedBox(width: 3),
              Text("votes",
                  style: boldStyle(
                    fontSize: Constant.smallFont,
                    color: hintColor,
                  )),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Text(item.commentLength.toString(),
                  style: boldStyle(
                    fontSize: Constant.mediumFont,
                    color: firstColor,
                  )),
              SizedBox(width: 3),
              Text("Answer",
                  style: boldStyle(
                    fontSize: Constant.smallFont,
                    color: hintColor,
                  )),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Text((item.commentLength + 3).toString(),
                  style: boldStyle(
                    fontSize: Constant.mediumFont,
                    color: firstColor,
                  )),
              SizedBox(width: 3),
              Text("Views",
                  style: boldStyle(
                    fontSize: Constant.smallFont,
                    color: hintColor,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget showTags() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: _materialName.map((e) {
        return Card(
          elevation: 0,
          color: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              e,
              style: lightStyle(fontSize: Constant.mediumFont, color: Colors.black54),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget showTopInfo(QuestionListItemParam item) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(120),
          child: Container(
            width: 30,
            height: 30,
            color: Colors.red,
          ),
        ),
        SizedBox(width: 4),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.userName,
              style: boldStyle(fontSize: Constant.mediumFont, color: firstColor),
            ),
            Text(item.time, style: boldStyle(fontSize: Constant.smallFont, color: thirdColor)),
          ],
        ),
      ],
    );
  }
}

class QuestionListItemParam {
  String userName;
  String time;
  int reactsLength;
  Function navigatorFunction;
  int commentLength;
  String title;
  String description;
  QuestionListItemParam(
      {@required this.navigatorFunction,
      @required this.commentLength,
      @required this.reactsLength,
      @required this.time,
      @required this.userName,
      @required this.title,
      @required this.description,
      });
}
