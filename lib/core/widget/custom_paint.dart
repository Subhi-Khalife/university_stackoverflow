import 'package:flutter/material.dart';

import 'colors.dart';

class CustomPaintWidget extends StatelessWidget {
  const CustomPaintWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        //color: colorSecondGrident,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.95,
      ),
      painter: HeaderCurvedContainer(),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = colorFirstGrident;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
