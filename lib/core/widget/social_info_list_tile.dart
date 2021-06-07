import 'package:flutter/material.dart';

import 'colors.dart';

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
          color: Theme.of(context).accentColor,
        ),
      ),
      subtitle: Text(
        userInfo,
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
      leading: Icon(
        socialIcon,
        color: Theme.of(context).accentColor,
      ),
    );
  }
}
