import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../../../core/widget/cached_newtwok_image_view.dart';
import '../../../../core/widget/colors.dart';
import '../../../../core/widget/custom_paint.dart';
import '../../../../core/widget/user_main_info.dart';
import '../../data/models/collage_profile.dart';
import '../bloc/collage_profile_bloc/collage_profile_bloc.dart';

class NewCollageProfile extends StatefulWidget {
  @override
  _NewCollageProfileState createState() => _NewCollageProfileState();
}

class _NewCollageProfileState extends State<NewCollageProfile> {
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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xff555555),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
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
              final user = state.collageProfileModel.data;
              return Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaintWidget(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Profile",
                          style: TextStyle(
                            fontSize: 35,
                            letterSpacing: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      profilePicWidget(context, user),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Container(
                        height: 400,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: UserMainInfo(
                          userData: user,
                          swiperWidget: swiperWidget(
                            context,
                            user,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Container(
                color: Colors.orangeAccent,
              );
            }
          },
        ),
      ),
    );
  }
}

Widget profilePicWidget(BuildContext context, Data user) {
  return Container(
    padding: EdgeInsets.all(10.0),
    width: MediaQuery.of(context).size.width / 2,
    height: MediaQuery.of(context).size.height / 4.3,
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 5,
      ),
      shape: BoxShape.circle,
      color: Colors.white,
      image: DecorationImage(
        image: NetworkImage(
          user.profilePic ??
              "https://miro.medium.com/max/1838/1*mk1-6aYaf_Bes1E3Imhc0A.jpeg",
        ),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget swiperWidget(BuildContext context, Data user) {
  return Container(
    height: MediaQuery.of(context).size.height / 3,
    width: MediaQuery.of(context).size.width,
    child: Swiper(
      itemBuilder: (context, index) {
        return CachedNetworkImageView(
          url: user.college.galleries[index].logo,
          function: () {},
        );
      },
      physics: ScrollPhysics(),
      autoplay: true,
      controller: SwiperController(),
      itemCount: user.college.galleries.length,
    ),
  );
}
