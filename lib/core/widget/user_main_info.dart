import 'package:flutter/material.dart';

import '../../features/collage_profile/data/models/collage_profile.dart';
import 'colors.dart';

class UserMainInfo extends StatelessWidget {
  final Data userData;
  final Widget swiperWidget;

  const UserMainInfo({
    Key key,
    this.userData,
    this.swiperWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          userData.firstName + " " + userData.lastName ?? "NoLast",
          style: TextStyle(
            color: blackWithOpacity,
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          userData.college.university.name + "  " + userData.college.name,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: blackWithOpacity,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        swiperWidget ?? Container(),
      ],
    );
  }
}
