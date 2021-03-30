import 'package:flutter/material.dart';
import 'package:university/core/widget/colors.dart';

class SocialInfoListTile extends StatelessWidget {
  final String socialType;
  final String userInfo;
  final IconData socialIcon;

  const SocialInfoListTile({
    Key key,
    this.socialType,
    this.userInfo,
    this.socialIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        socialType,
        style: TextStyle(
          color: colorWhite,
        ),
      ),
      subtitle: Text(
        userInfo,
        style: TextStyle(
          color: colorWhite,
        ),
      ),
      leading: Icon(
        socialIcon,
        color: colorWhite,
      ),
    );
  }
}
