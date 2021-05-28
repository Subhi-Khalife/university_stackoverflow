import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class CommentTextField extends StatefulWidget {
  final TextEditingController commentController;
  final bool isUpdateClickIcon;
  final Function sendMessage;
  final Function cancelUpdate;
  CommentTextField({
    @required this.commentController,
    @required this.isUpdateClickIcon,
    @required this.sendMessage,
    @required this.cancelUpdate,
  });
  @override
  State<StatefulWidget> createState() {
    return _CommentTextField();
  }
}

class _CommentTextField extends State<CommentTextField>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    String oldMessage = widget.commentController.text;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Column(
            children: [
              AnimatedSize(
                vsync: this,
                curve: Curves.easeOut,
                duration: Duration(milliseconds: 400),
                child: Container(
                  color: blackWithOpacity,
                  height: (widget.isUpdateClickIcon) ? 40 : 0,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            oldMessage,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.clear,color: Colors.white),
                            onPressed: widget.cancelUpdate)
                      ],
                    ),
                  ),
                ),
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                textInputAction: TextInputAction.done,
                textDirection:
                    Localizations.localeOf(context).toString() == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                textAlign: Localizations.localeOf(context).toString() == 'ar'
                    ? TextAlign.right
                    : TextAlign.left,
                controller: widget.commentController,
                minLines: 1,
                autocorrect: true,
                maxLines: 6,
                scrollPhysics: ScrollPhysics(),
                scrollPadding: EdgeInsets.all(5),
                decoration: InputDecoration(
                  suffixIcon: Localizations.localeOf(context).toString() != 'ar'
                      ? IconButton(
                          icon: Icon(Icons.send, color: greyColor),
                          onPressed: widget.sendMessage)
                      : null,
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: blackWithOpacity,
                  filled: true,
                  hintText: "search hear",
                  prefixIcon: Localizations.localeOf(context).toString() == 'ar'
                      ? IconButton(
                          icon: Icon(Icons.sort, color: greyColor),
                          onPressed: widget.sendMessage)
                      : null,
                  hintStyle: TextStyle(color: greyColor),
                  contentPadding: EdgeInsets.only(left: 8, right: 8),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blackWithOpacity),
                    borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: blackWithOpacity),
                    borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                  ),
                ),
                onSubmitted: (c) => widget.sendMessage,
                smartDashesType: SmartDashesType.enabled,
                smartQuotesType: SmartQuotesType.enabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
