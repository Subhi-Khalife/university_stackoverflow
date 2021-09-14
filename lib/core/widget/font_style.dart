import 'package:flutter/cupertino.dart';

lightStyle({@required double fontSize, @required Color color}) {
  return TextStyle(fontSize: fontSize, color: color, fontFamily: "nexa_light", height: 1.2);
}

regularStyle({@required double fontSize, @required Color color}) {
  return TextStyle(fontSize: fontSize, color: color, fontFamily: "nexa_bold", height: 1.2);
}

boldStyle({@required double fontSize, @required Color color}) {
  return TextStyle( fontSize: fontSize, color: color, fontFamily: "nexa_bold", height: 1.2);
}
