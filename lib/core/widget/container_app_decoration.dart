import 'package:flutter/cupertino.dart';
import 'package:university/core/widget/colors.dart';

Decoration containerDecoration() {
  return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      gradient: LinearGradient(
        colors: [
          colorFirstGrident,
          colorSecondGrident,
        ],
        stops: [0.0, 1],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ));
}
