import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:university/core/widget/cached_newtwok_image_view.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/social_info_list_tile.dart';
import 'package:university/core/widget/statics.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: CachedNetworkImageView(
                url:
                    "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 200, 15, 15),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                          color: colorThemApp,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: userMainInfo(context),
                      ),
                      userImage(),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: colorThemApp,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: userSubInfo(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userMainInfo(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            left: 95,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mohammed",
                style: TextStyle(
                  color: colorWhite,
                  fontSize: 25,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  "ITE",
                  style: TextStyle(
                    color: colorWhite,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            StaticsWidget(
              number: 40,
              label: "Subsecribers",
            ),
            StaticsWidget(
              number: 600,
              label: "Views",
            ),
            StaticsWidget(
              number: 60,
              label: "Videos",
            ),
          ],
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget userImage() {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 10,
            color: secondColor,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(
            "https://miro.medium.com/max/1200/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget userSubInfo() {
    return Column(
      children: [
        ListTile(
          title: Text(
            "UserInfo",
            style: TextStyle(
              color: colorWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(),
        SocialInfoListTile(
          socialType: "e-mail",
          userInfo: "mohamedatta900@gmail.com",
          socialIcon: Icons.email,
        ),
        SocialInfoListTile(
          socialType: "instagram",
          userInfo: "mohamedatta900@gmail.com",
          socialIcon: LineIcons.instagram,
        ),
        SocialInfoListTile(
          socialType: "Facebook",
          userInfo: "mohamedatta900@gmail.com",
          socialIcon: LineIcons.facebook,
        ),
        SocialInfoListTile(
          socialType: "Twitter",
          userInfo: "mohamedatta900@gmail.com",
          socialIcon: LineIcons.twitter,
        ),
        SocialInfoListTile(
          socialType: "Joined date",
          userInfo: "25 Sep 2020",
          socialIcon: Icons.calendar_view_day,
        ),
      ],
    );
  }
}
