import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';

import '../../../../core/widget/cached_newtwok_image_view.dart';
import '../../../../core/widget/colors.dart';
import '../../../../core/widget/social_info_list_tile.dart';
import '../../../../core/widget/statics.dart';
import '../../data/models/collage_profile.dart';
import '../bloc/collage_profile_bloc/collage_profile_bloc.dart';
import 'gallery_page.dart';

class CollageProfilePage extends StatefulWidget {
  const CollageProfilePage({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<CollageProfilePage> {
  CollageProfileBloc collageProfileBloc;

  @override
  void initState() {
    super.initState();
    collageProfileBloc = CollageProfileBloc()
      ..add(
        FetchCollageProfile(),
      );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    collageProfileBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => collageProfileBloc,
      child: BlocBuilder<CollageProfileBloc, CollageProfileState>(
        builder: (context, state) {
          if (state is GettingCollageProfileFailed) {
            print("Done");
            return Container(
              color: Colors.red,
            );
          } else if (state is GettingCollageProfileLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: colorThemApp,
              ),
            );
          } else if (state is GettingCollageProfileSuccess) {
            return SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: CachedNetworkImageView(withBaseUrl: false,
                      url: state.collageProfileModel.data.profilePic ??
                          "https://shotkit.com/wp-content/uploads/2021/05/share-photos.jpg",
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
                              child: userMainInfo(
                                  context, state.collageProfileModel.data),
                            ),
                            userImage(
                              state.collageProfileModel.data.profilePic ??
                                  "https://miro.medium.com/max/1838/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
                            ),
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
                          child: userSubInfo(state.collageProfileModel.data),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              color: Colors.orangeAccent,
            );
          }
        },
      ),
    ));
  }

  Widget userMainInfo(BuildContext context, Data data) {
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
                data.firstName,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 25,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  data.college.university.name + "\t" + data.college.name,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
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
              number: data.college.galleries.length,
              label: "Gallery",
              gestureTapCallback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return GalleryPage(
                      galleries: data.college.galleries,
                    );
                  }),
                );
              },
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

  Widget userSubInfo(Data data) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "UserInfo",
            style: boldStyle(
              color: Theme.of(context).accentColor,
              fontSize: Constant.mediumFont,
            ),
          ),
        ),
        Divider(),
        SocialInfoListTile(
          socialType: "e-mail",
          userInfo: data.email,
          socialIcon: Icons.email,
        ),
        SocialInfoListTile(
          socialType: "instagram",
          userInfo: "mohamedatta900@gmail.com",
          socialIcon: LineIcons.instagram,
        ),
        SocialInfoListTile(
          socialType: "Facebook",
          userInfo: data.facebookUrl ?? "test@gmail.com",
          socialIcon: LineIcons.facebook,
        ),
        SocialInfoListTile(
          socialType: "LinkedIn",
          userInfo: data.linkedInUrl ?? "Test@gmail.com",
          socialIcon: LineIcons.linkedin,
        ),
        SocialInfoListTile(
          socialType: "Mobile",
          userInfo: data.mobile ?? "003544",
          socialIcon: Icons.phone_android,
        ),
      ],
    );
  }
}
