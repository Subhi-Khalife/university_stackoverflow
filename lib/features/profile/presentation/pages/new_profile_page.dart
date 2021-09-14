import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/entities/user.dart';
import 'package:university/features/collage_profile/presentation/bloc/collage_profile_bloc/collage_profile_bloc.dart';
import 'package:university/features/profile/presentation/pages/normal_user_information.dart';
import 'package:university/features/profile/presentation/pages/user_gallery.dart';
import 'normal_user_collapsing_tab.dart';

// ignore: must_be_immutable
class NormalUserProfile extends StatefulWidget {
  static const routeName = '/profile_provider';
  final String userId;
  User user;
  NormalUserProfile({this.userId, this.user});
  @override
  State<StatefulWidget> createState() {
    return _ProfileProviderScreen();
  }
}

class _ProfileProviderScreen extends State<NormalUserProfile> with AutomaticKeepAliveClientMixin {
  ScrollController scrollController = ScrollController();
  CollageProfileBloc collageProfileBloc;
  ConstantInfo constantInfo = ConstantInfo.getInstance();
  @override
  void initState() {
    super.initState();
    if (widget.user == null) {
      widget.user = constantInfo.userInfo;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    super.build(context);
    return Scaffold(
      body: CollapsingNormalUser(
        user: widget.user,
        scrollController: scrollController,
        userId: widget.userId,
        tabs: [
          Tab(text: "Global Information"),
          Tab(text: "gallery"),
          // Tab(text: "Posts"),
        ],
        tabsBody: [
          NormalUserInformation(userInfo: widget.user),
          GalleryNoramlUserPage(
            galleries: widget.user.galleryUsers,
          ),
          // Container(
          //   child: Center(
          //     child: Text("gallery"),
          //   ),
          // )
        ],
      ),
    );
  }
}
