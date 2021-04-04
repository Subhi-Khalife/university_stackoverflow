import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:university/core/entities/user.dart';
import 'package:university/core/widget/cached_newtwok_image_view.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/social_info_list_tile.dart';
import 'package:university/core/widget/statics.dart';
import 'package:university/features/profile/presentation/bloc/bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileBloc profileBloc;

  _ProfilePageState({this.profileBloc});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileBloc = ProfileBloc()
      ..add(FetchProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => profileBloc,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileIsLoadedState) {
            print("Done");
            return SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: CachedNetworkImageView(
                      url: "https://miro.medium.com/max/1838/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
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
                              child: userMainInfo(context, state.user),
                            ),
                            userImage(
                                "https://miro.medium.com/max/1838/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg"),
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
                          child: userSubInfo(state.user),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProfileIsLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: colorThemApp,
              ),
            );
          } else {
            return FlatButton(
              onPressed: () {
                BlocProvider.of<ProfileBloc>(context)
                  ..add(
                    FetchProfile(),
                  );
              },
              child: Text("Test"),
            );
          }
        },
      ),
    ));
  }

  Widget userMainInfo(BuildContext context, User user) {
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
                user.firstName,
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

  Widget userImage(String url) {
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
            url,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget userSubInfo(User user) {
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
          userInfo: user.email,
          socialIcon: Icons.email,
        ),
        SocialInfoListTile(
          socialType: "instagram",
          userInfo: "mohamedatta900@gmail.com",
          socialIcon: LineIcons.instagram,
        ),
        SocialInfoListTile(
          socialType: "Facebook",
          userInfo: "Test@gmail.com",
          socialIcon: LineIcons.facebook,
        ),
        SocialInfoListTile(
          socialType: "LinkedIn",
          userInfo: "Test@gmail.com",
          socialIcon: LineIcons.linkedin,
        ),
        SocialInfoListTile(
          socialType: "Mobile",
          userInfo: user.mobile,
          socialIcon: Icons.phone_android,
        ),
      ],
    );
  }
}
