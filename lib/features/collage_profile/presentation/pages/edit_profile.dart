import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/features/collage_profile/presentation/pages/new_collage_profile.dart';

import '../../../../core/widget/colors.dart';
import '../../../../core/widget/custom_paint.dart';
import '../../../../core/widget/user_main_info.dart';
import '../../data/models/collage_profile.dart';
import '../bloc/collage_profile_bloc/collage_profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
    super.dispose();
    collageProfileBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: colorFirstGrident,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save_alt),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => NewCollageProfile(),
                ),
              );
            },
          ),
        ],
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
                            color: greyColor,
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
                        height: 350,
                        //color: colorFirstGrident,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: ListView(
                          children: [
                            UserMainInfo(
                              userData: user,
                            ),
                            editUserInfo(context),
                          ],
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

Widget editUserInfo(BuildContext context) {
  return Container(
    //color: colorFirstGrident,
    width: MediaQuery.of(context).size.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Edit Profile",
          style: TextStyle(
            color: colorFirstGrident,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        textFieldWidget(
          "Change e-mail",
        ),
        SizedBox(height: 10),
        textFieldWidget(
          "Old password",
          showPassword: true,
        ),
        SizedBox(height: 10),
        textFieldWidget(
          "New password",
          showPassword: true,
        ),
        SizedBox(height: 10),
        textFieldWidget(
          "Confirm new password",
          showPassword: true,
        ),
      ],
    ),
  );
}

Widget textFieldWidget(String hintText, {bool showPassword}) {
  return TextField(
    controller: TextEditingController(),
    enabled: true,
    style: TextStyle(
      color: colorWhite,
    ),
    decoration: InputDecoration(
      filled: true,
      fillColor: blackWithOpacity,
      hintText: hintText,
      hintStyle: TextStyle(
        color: colorWhite,
      ),
    ),
  );
}

Widget profilePicWidget(BuildContext context, Data user) {
  return Container(
    padding: EdgeInsets.all(10.0),
    width: MediaQuery.of(context).size.width / 2,
    height: MediaQuery.of(context).size.height / 4.3,
    decoration: BoxDecoration(
      border: Border.all(
        color: greyColor,
        width: 5,
      ),
      shape: BoxShape.circle,
      color: colorFirstGrident,
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
