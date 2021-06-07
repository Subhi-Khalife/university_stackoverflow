import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/core/widget/show_message.dart';
import 'package:university/features/collage_profile/presentation/pages/new_collage_profile.dart';
import 'package:university/features/collage_profile/presentation/pages/profile_page.dart';
import 'package:university/features/collage_profile/presentation/pages/profile_provider_screen.dart';
import 'package:university/features/common_question/presentation/bloc/common_question/common_question_bloc.dart';
import 'package:university/features/feedback/presentation/pages/feedback_screen.dart';
import 'package:university/features/login/presentation/pages/login_screen.dart';
import 'package:university/features/profile/presentation/pages/new_profile_page.dart';
import 'package:university/features/sign_up/presentation/pages/sign_up_screen.dart';
import 'package:university/features/splash_screen/presentation/pages/splash_screen.dart';
import 'package:university/features/university_with_collage/presentation/bloc/bloc/university_bloc.dart';
import 'package:university/features/university_with_collage/presentation/pages/drop_down.dart';

import '../constant_info.dart';
import 'app_button.dart';

class DrawerItem extends StatefulWidget {
  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> with TickerProviderStateMixin {
  final ConstantInfo constantInfo = ConstantInfo.getInstance();
  CommonQuestionBloc blocItem = CommonQuestionBloc();

  bool loginSuccess = false;

  @override
  Widget build(BuildContext context) {
    loginSuccess = constantInfo.sharedPreferences.getBool("loginSuccess");
    return Drawer(
      elevation: 10.0,
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 35.0),
                  Center(
                    child: Text(
                      "UniverSity App",
                      style: boldStyle(
                          fontSize: Constant.xlargeFont,
                          color: Theme.of(context).hintColor),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  (loginSuccess) ? loginItem(context) : logout(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropDownCollage() {
    return BlocListener<UniversityBloc, UniversityState>(
      listener: (context, state) {},
      child: BlocBuilder<UniversityBloc, UniversityState>(
        builder: (context, state) {
          if (state is UniversityState) {
            return Container(
              child: Column(
                children: [
                  DropDown(
                    dropDownListItem: state.univerSityItems,
                    title: state.universityName,
                    isOpened: false,
                    universitySelecetd: true,
                  ),
                  SizedBox(height: 10),
                  AnimatedSize(
                    duration: Duration(milliseconds: 500),
                    vsync: this,
                    child: (state.universityId != -1)
                        ? DropDown(
                            dropDownListItem: state.collegeityItems,
                            title: state.collageName,
                            isOpened: false,
                            universitySelecetd: false,
                          )
                        : Container(),
                  ),
                ],
              ),
            );
          } else if (state is UniversityIsLoadingState) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: colorThemApp,
            ));
          } else if (state is UniversityIsLoadErrorState) {
            return Container(
              color: Colors.red,
              width: 50,
              height: 50,
            );
          } else {
            return Container(
              color: Colors.orange,
              width: 50,
              height: 50,
            );
          }
        },
      ),
    );
  }

  Future dialogToNavigatorUniv() {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33)),
      enableDrag: true,
      builder: (BuildContext context) {
        return BlocProvider<UniversityBloc>(
          create: (context) => UniversityBloc()..add(FetchUiversity()),
          child: BlocBuilder<UniversityBloc, UniversityState>(
              builder: (context, state) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Explore multi university",
                    style: boldStyle(
                        fontSize: Constant.mediumFont,
                        color: Theme.of(context).hintColor),
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: dropDownCollage(),
                ),
                AppButton(
                    function: () {
                      if(state.collageId==-1)
                      showMessage("Please choose colage");
                      else
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProfileProviderScreen(
                              collageId: state.collageId)));
                    },
                    name: "Go To Selected Collage",
                    buttonColor: Theme.of(context).primaryColor,
                    fontColor: Theme.of(context).accentColor)
              ],
            );
          }),
        );
      },
    );
  }

  Widget logout(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        // InkWell(
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) {
        //           return FeedbackScreen();
        //         },
        //       ),
        //     );
        //   },
        //   child: Row(
        //     children: [
        //       SizedBox(width: 15),
        //       Icon(
        //         Icons.feedback,
        //         color: Theme.of(context).hintColor,
        //       ),
        //       SizedBox(width: 15),
        //       Text(
        //         "Feedback",
        //         style: boldStyle(
        //           fontSize: Constant.mediumFont,
        //           color: Theme.of(context).hintColor,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(height: 20.0),
        // InkWell(
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) {
        //           return NewCollageProfile();
        //         },
        //       ),
        //     );
        //   },
        //   child: Row(
        //     children: [
        //       SizedBox(width: 15),
        //       Icon(
        //         Icons.person,
        //         color: Theme.of(context).hintColor,
        //       ),
        //       SizedBox(width: 15),
        //       Text(
        //         "Profile",
        //         style: boldStyle(
        //           fontSize: Constant.mediumFont,
        //           color: Theme.of(context).hintColor,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          },
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(
                Icons.work_off_sharp,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(width: 15),
              Text(
                "SignUp",
                style: boldStyle(
                  fontSize: Constant.mediumFont,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false);
          },
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(
                Icons.login,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(width: 15),
              Text(
                "Login",
                style: boldStyle(
                  fontSize: Constant.mediumFont,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        InkWell(
          onTap: () {
            dialogToNavigatorUniv();
          },
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(
                Icons.house,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(width: 15),
              Text(
                "Show all university",
                style: boldStyle(
                  fontSize: Constant.mediumFont,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget loginItem(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return FeedbackScreen();
                },
              ),
            );
          },
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(
                Icons.feedback,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(width: 15),
              Text(
                "Feedback",
                style: boldStyle(
                  fontSize: Constant.mediumFont,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return NormalUserProfile();
                },
              ),
            );
          },
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(
                Icons.person,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(width: 15),
              Text(
                "Profile",
                style: boldStyle(
                  fontSize: Constant.mediumFont,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ProfileProviderScreen(
                    collageId: constantInfo.userInfo.collegeId,
                  );
                },
              ),
            );
          },
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(
                Icons.house,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(width: 15),
              Text(
                "CollageProfile",
                style: boldStyle(
                  fontSize: Constant.mediumFont,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        InkWell(
          onTap: () {
            constantInfo.sharedPreferences.setBool("loginSuccess", false);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SplashScreen()),
                (Route<dynamic> route) => false);
          },
          child: Row(
            children: [
              SizedBox(width: 15),
              Icon(
                Icons.logout,
                color: Theme.of(context).hintColor,
              ),
              SizedBox(width: 15),
              Text(
                "Logout",
                style: boldStyle(
                  fontSize: Constant.mediumFont,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
