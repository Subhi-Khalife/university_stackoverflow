import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/show_svg_image.dart';

import 'colors.dart';

class TextFieldApp extends StatelessWidget {
  final TextInputType textInputType;
  final bool withIcon;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onSubmitted;
  final TextInputAction textInputAction;
  final String labelText;
  final IconData icon, prefixIcon;
  final bool isLookAtPassword;
  final Function onPressedLookAtPassword;
  final bool isTextFieldPassword, filled, isSvgPrefix;
  final Color colorsIcon, colorFill;
  final Function onChanged;
  final String prefixSvg;
  final Color prefixIconColor;
  final String hintText;
  final Color colorText;
  final int maxLength;
  final bool withBottomBlackLine;
  final TextStyle style;
  final int maxLines;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  final Widget suffixIcon;
  final bool enabled;
  Key key;

  TextFieldApp(
      {@required this.controller,
      this.prefixIconColor = null,
      this.withBottomBlackLine = true,
      this.hintText = "",
      this.textInputType = TextInputType.text,
      this.withIcon = true,
      this.focusNode,
      this.style,
      this.colorText,
      this.onSubmitted,
      this.textInputAction,
      this.labelText,
      this.icon,
      this.suffixIcon,
      this.isSvgPrefix,
      this.prefixSvg = "",
      this.prefixIcon,
      this.isLookAtPassword,
      this.onPressedLookAtPassword,
      @required this.isTextFieldPassword,
      this.colorsIcon = Colors.grey,
      this.onChanged,
      this.maxLines,
      this.filled,
      this.colorFill,
      this.paddingTop,
      this.paddingBottom,
      this.paddingLeft,
      this.paddingRight,
      this.key,
      this.enabled,
      this.maxLength = 0});

  @override
  Widget build(BuildContext context) {
    return isTextFieldPassword
        ? TextField(
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            style: style == null
                ? TextStyle(
                    color: (colorText) ?? colorThemApp,
                    fontSize: Constant.verySmallFont)
                : style,
            cursorColor: thirdColor,
            obscureText: !isLookAtPassword,
            decoration: InputDecoration(
                border:
                    (withBottomBlackLine == false) ? InputBorder.none : null,
                enabledBorder:
                    (withBottomBlackLine == false) ? InputBorder.none : null,
                errorBorder:
                    (withBottomBlackLine == false) ? InputBorder.none : null,
                disabledBorder:
                    (withBottomBlackLine == false) ? InputBorder.none : null,
                hintStyle: TextStyle(
                  color: thirdColor,
                  fontSize: 10,
                ),
                contentPadding: EdgeInsets.only(
                    top: paddingTop ?? 10,
                    right: paddingRight ?? 0.0,
                    bottom: paddingBottom ?? 12.0,
                    left: paddingLeft ?? 4.0),
                labelText: labelText,
                hintText: hintText,
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                    color: thirdColor.withOpacity(0.4),
                    height: -8,
                    fontSize: Constant.smallFont),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: IconButton(
                    icon: Icon(
                        isLookAtPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: colorsIcon,
                        size: 18),
                    onPressed: onPressedLookAtPassword,
                  ),
                ),
                focusedBorder: (withBottomBlackLine == false)
                    ? InputBorder.none
                    : UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorThemApp, width: 1.5))),
          )
        : TextField(
            key: key,
            onChanged: onChanged,
            keyboardType: textInputType,
            inputFormatters: (maxLength != 0)
                ? [
                    LengthLimitingTextInputFormatter(maxLength),
                    (textInputType == TextInputType.phone ||
                            textInputType == TextInputType.number)
                        ? WhitelistingTextInputFormatter(RegExp("[0-9]"))
                        : BlacklistingTextInputFormatter(RegExp("[/\\\\]")),
                  ]
                : [
                    (textInputType == TextInputType.phone ||
                            textInputType == TextInputType.number)
                        ? WhitelistingTextInputFormatter(RegExp("[0-9]"))
                        : BlacklistingTextInputFormatter(RegExp("[/\\\\]")),
                  ],
            controller: controller,
            focusNode: focusNode,
            enabled: enabled ?? true,
            maxLines: maxLines ?? 1,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            style: style == null
                ? TextStyle(color: (colorText) ?? colorThemApp, fontSize: 16)
                : style,
            cursorColor: thirdColor,
            decoration: InputDecoration(
                filled: filled,
                fillColor: colorFill,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                border:
                    (withBottomBlackLine == false) ? InputBorder.none : null,
                enabledBorder:
                    (withBottomBlackLine == false) ? InputBorder.none : null,
                errorBorder:
                    (withBottomBlackLine == false) ? InputBorder.none : null,
                disabledBorder:
                    (withBottomBlackLine == false) ? InputBorder.none : null,
                contentPadding: EdgeInsets.only(
                    top: paddingTop ?? 10,
                    right: paddingRight ?? 0.0,
                    bottom: paddingBottom ?? 12.0,
                    left: paddingLeft ?? 4.0),
                // hintText: hintText,
                hintStyle: TextStyle(
                  color: thirdColor,
                  fontSize: Constant.smallFont,
                ),
                suffixIcon: suffixIcon,
                prefixIcon: isSvgPrefix ?? false
                    ? Transform.scale(
                        scale: 0.4,
                        child: showSvgImage(
                          svgPath: prefixSvg,
                          coloSvg: thirdColor,
                          height: 10,
                          width: 10,
                        ),
                      )
                    : null,
                labelText: labelText,
                hintText: hintText,
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                    color: thirdColor.withOpacity(0.4),
                    height: -8,
                    fontSize: Constant.smallFont),
                focusedBorder: (withBottomBlackLine == false)
                    ? InputBorder.none
                    : UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: colorThemApp, width: 1.50))),
          );
  }
}
