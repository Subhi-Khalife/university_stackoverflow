import 'package:flutter/material.dart';
import 'package:university/core/widget/colors.dart';

class StaticsWidget extends StatelessWidget {
  final int number;
  final String label;

  const StaticsWidget({
    Key key,
    this.number,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            number.toString(),
            style: TextStyle(
              color: colorWhite,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: colorWhite,
            ),
          ),
        ],
      ),
    );
  }
}
