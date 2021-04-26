import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function function;
  DropDownTextField({this.controller, this.hintText = "",this.function});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: TextField(
              onTap: function,
              textDirection:
                  Localizations.localeOf(context).toString() == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
              textAlign:
                  Localizations.localeOf(context).toString() == 'ar'
                      ? TextAlign.right
                      : TextAlign.left,
              controller: controller,
              minLines: 1,
              autocorrect: true,
              maxLines: 6,
              scrollPhysics: ScrollPhysics(),
              scrollPadding: EdgeInsets.all(5),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  fillColor: Color(0xfff2f2f2),
                  filled: true,
                  hintText: hintText,
                  hintStyle:
                      TextStyle(color: Theme.of(context).primaryColor),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 9),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(22.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(22.0)),
                  )),
              smartDashesType: SmartDashesType.enabled,
              smartQuotesType: SmartQuotesType.enabled,
            )),
      ),
    );
  }
}
