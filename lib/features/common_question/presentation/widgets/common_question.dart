import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/features/common_question/presentation/widgets/common_question_content.dart';

import '../../../../core/entities/common_question.dart';
import '../../../../core/widget/colors.dart';
import '../../../../core/widget/constant.dart';
import '../../../../core/widget/font_style.dart';

class CommonQuestionView extends StatelessWidget {
  final CommonQuestion commonQuestionItem;
  CommonQuestionView({this.commonQuestionItem});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CommonQuestionContent(
                  commonQuestionItem: commonQuestionItem,
                )));
      },
      child: Container(
        height: 140,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                colorFirstGrident,
                colorSecondGrident,
              ],
              stops: [0.4, 0.77],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(commonQuestionItem.question,
                  style: boldStyle(
                    fontSize: Constant.mediumFont,
                    color: Colors.grey,
                  ),
                  maxLines: 2),
              Spacer(),
              Text(
                "57K views",
                style: boldStyle(
                    fontSize: Constant.smallFont, color: Colors.white),
              ),
              Spacer(),
              Transform.translate(
                offset: Offset(0, 10),
                child: Container(
                  child: Card(
                    color: Colors.white60.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 6, bottom: 6, right: 12, left: 12),
                      child: Text("Click to answer"),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

    //                     SizedBox(height: 8),
    //                     Text(
    //                       DateFormat('kk:mm')
    //                           .format(commonQuestionItem.createdAt),
    //                       style: regularStyle(
    //                           fontSize: Constant.mediumFont, color: secondColor),
    //                     )
    //                   ],
    //                 ),
    //                 Text(
    //                   "Aleppo university",
    //                   style: regularStyle(
    //                       fontSize: Constant.mediumFont, color: firstColor),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Padding(
    //             padding:
    //                 EdgeInsets.only(top: 12, bottom: 12, left: 6, right: 6),
    //             child: Text(
    //               commonQuestionItem.question,
    //               style: regularStyle(
    //                   fontSize: Con  // return Padding(
    //   padding: EdgeInsets.only(left: 6, right: 6),
    //   child: InkWell(
    //     onTap: () {
    //       Navigator.of(context).push(MaterialPageRoute(
    //           builder: (context) => CommonQuestionContent(
    //               commonQuestionItem: commonQuestionItem)));
    //     },
    //     child: Card(
    //       elevation: 4,color: Colors.grey.shade100,
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Padding(
    //             padding:
    //                 EdgeInsets.only(top: 16, bottom: 12, left: 8, right: 8),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       DateFormat('yyyy-MM-dd – kk:mm')
    //                           .format(commonQuestionItem.createdAt),
    //                       style: regularStyle(
    //                           fontSize: Constant.mediumFont, color: secondColor),
    //                     ),stant.mediumFont, color: firstColor),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
