import 'package:flutter/material.dart';
import 'package:university/features/collage_profile/data/models/collage_profile.dart';

class UserMainInfo extends StatelessWidget {
  final Data userDart;

  const UserMainInfo({
    Key key,
    this.userDart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          userDart.firstName + " " + userDart.lastName ?? "NoLast",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 30,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          userDart.college.university.name + "  " + userDart.college.name,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
