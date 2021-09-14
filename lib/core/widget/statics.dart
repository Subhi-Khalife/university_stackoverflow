import 'package:flutter/material.dart';

import 'colors.dart';

class StaticsWidget extends StatelessWidget {
  final int number;
  final String label;
  final GestureTapCallback gestureTapCallback;

  const StaticsWidget({
    Key key,
    this.number,
    this.label,
    this.gestureTapCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: gestureTapCallback,
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
      ),
    );
  }
}
