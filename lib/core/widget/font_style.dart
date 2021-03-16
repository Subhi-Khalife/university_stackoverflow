import 'package:flutter/cupertino.dart';

lightStyle({@required double fontSize, @required Color color}) {
  return TextStyle(fontSize: fontSize, color: color, fontFamily: "light", height: 1.2);
}

regularStyle({@required double fontSize, @required Color color}) {
  return TextStyle(fontSize: fontSize, color: color, fontFamily: "regular", height: 1.2);
}

boldStyle({@required double fontSize, @required Color color}) {
  return TextStyle( fontSize: fontSize, color: color, fontFamily: "bold", height: 1.2);
}
