import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/core/widget/FontFamily.dart';
import 'package:university/core/widget/cached_newtwok_image_view.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';


// ignore: must_be_immutable
class CommentWidget extends StatelessWidget {
  Function deleteFunction = () {};
  Function updateFunction = () {};
  final CommentItem commentItem;
  List<Function> popMenuFunction = [];
  final bool withPopMenu;
  CommentWidget({
    @required this.commentItem,
    this.deleteFunction,
    this.updateFunction,
    this.withPopMenu = true,
  }) {
    popMenuFunction = [deleteFunction, updateFunction];
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            commentItem.function();
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: blackWithOpacity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(120)),
                      child: Container(
                          height: 35,
                          width: 35,
                          child: CachedNetworkImageView(
                              url: commentItem.imageUrl, withBaseUrl: false))),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            commentItem.userName,
                            style: regularStyle(
                                fontSize: Constant.mediumFont,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10),
                        Flexible(
                          flex: 31,
                          child: Text(
                            commentItem.description,
                            style: regularStyle(
                                fontSize: Constant.smallFont,
                                color: Theme.of(context).hintColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        myPopMenu(context)
      ],
    );
  }

  Widget myPopMenu(BuildContext context) {
    if (!withPopMenu) return Container();
    return Align(
      alignment: Alignment.topRight,
      child: PopupMenuButton(
        padding: EdgeInsets.only(bottom: 4),
        onSelected: (value) {
          if (value == 1) {
            updateFunction();
          } else {
            deleteFunction();
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
              value: 1,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                    child: Icon(Icons.edit),
                  ),
                  Text('Edit')
                ],
              )),
          PopupMenuItem(
            value: 2,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                  child: Icon(Icons.delete),
                ),
                Text('Delete')
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentItem {
  final Function function;
  final String description;
  final String imageUrl;
  final String userName;
  CommentItem({this.description, this.function, this.imageUrl, this.userName});
}
