import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/Drawer.dart';
import 'package:university/core/widget/FontFamily.dart';
import 'package:university/core/widget/container_app_decoration.dart';

import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/bloc_error_screen.dart';
import '../../../../core/widget/colors.dart';
import '../../../../core/widget/comment_text_field.dart';
import '../../../../core/widget/config_screeen.dart';
import '../../../../core/widget/constant.dart';
import '../../../../core/widget/font_style.dart';
import '../../../../core/widget/loading_view.dart';
import '../../../collage_profile/presentation/pages/new_collage_profile.dart';
import '../../../login/presentation/pages/login_screen.dart';
import '../../../sign_up/presentation/pages/sign_up_screen.dart';
import '../../../university_with_collage/presentation/bloc/bloc/university_bloc.dart';
import '../../../university_with_collage/presentation/pages/drop_down.dart';
import '../bloc/common_question/common_question_bloc.dart';
import '../widgets/common_question.dart';

class PublicCommonQuestion extends StatefulWidget {
  final int collageId;
  PublicCommonQuestion({this.collageId=-1});
  @override
  State<StatefulWidget> createState() {
    return _PublicCommonQuestion();
  }
}

class _PublicCommonQuestion extends State<PublicCommonQuestion>
    with TickerProviderStateMixin {
  CommonQuestionBloc blocItem;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if(widget.collageId==-1)
    blocItem = CommonQuestionBloc()..add(GetAllCommonQuestionEvent());
    else 
    blocItem = CommonQuestionBloc()..add(GetAllCommonQuestionForSelectedCollageEvent(collageId: widget.collageId.toString()));
    if(widget.collageId==-1)
    Future.delayed(Duration(seconds: 0)).then((_) {
      beginBottomSheet();
    });
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

  Future beginBottomSheet() {
    ValueNotifier<bool> checkBox = ValueNotifier(false);
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      enableDrag: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: containerDecoration(),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Continue as visitor",
                          style: regularStyle(
                              fontSize: Constant.largeFont,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "OR",
                  style: regularStyle(
                    fontSize: Constant.smallFont,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: Container(
                            decoration: containerDecoration(),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "Login",
                                  style: regularStyle(
                                      fontSize: Constant.mediumFont,
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: Container(
                            decoration: containerDecoration(),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "Sign up",
                                  style: regularStyle(
                                      fontSize: Constant.mediumFont,
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueListenableBuilder(
                        valueListenable: checkBox,
                        builder: (context, value, _) {
                          return Checkbox(
                              fillColor: MaterialStateProperty.all(
                                  Theme.of(context).primaryColor),
                              value: value,
                              onChanged: (c) {
                                checkBox.value = !checkBox.value;
                              });
                        }),
                    Text(
                      "Don't show this again ",
                      style: regularStyle(
                        fontSize: Constant.smallFont,
                        color: Theme.of(context).accentColor,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }


  Future showButtomSheet() {
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
                    "Filter your search",
                    style: boldStyle(
                        fontSize: Constant.mediumFont, color: Theme.of(context).hintColor),
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: dropDownCollage(),
                ),
                AppButton(
                  function: () {
                    blocItem.add(GetAllCommonQuestionForSelectedCollageEvent(
                        collageId: state.collageId.toString()));
                    Navigator.of(context).pop();
                  },
                  name: "Search",
                  buttonColor: Theme.of(context).primaryColor,
                  fontColor: Theme.of(context).accentColor
                )
              ],
            );
          }),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    blocItem.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: (widget.collageId==-1)?DrawerItem():null

      //  Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.only(top: 52, bottom: 12, left: 8, right: 8),
      //     children: [
      //       InkWell(
      //         onTap: () {
      //           Navigator.of(context).push(MaterialPageRoute(
      //             builder: (context) => LoginScreen(),
      //           ));
      //         },
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text(
      //               "Login",
      //               style: boldStyle(
      //                   fontSize: Constant.mediumFont, color: firstColor),
      //             ),
      //             Icon(Icons.login)
      //           ],
      //         ),
      //       ),
      //       SizedBox(height: 18),
      //       InkWell(
      //         onTap: () {
      //           Navigator.of(context).push(MaterialPageRoute(
      //             builder: (context) => SignUpScreen(),
      //           ));
      //         },
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text(
      //               "Signup",
      //               style: boldStyle(
      //                   fontSize: Constant.mediumFont, color: firstColor),
      //             ),
      //             Icon(Icons.login)
      //           ],
      //         ),
      //       ),
      //       InkWell(
      //         onTap: () {
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (context) => NewCollageProfile(),
      //             ),
      //           );
      //         },
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text(
      //               "Collage Profile",
      //               style: boldStyle(
      //                   fontSize: Constant.mediumFont, color: firstColor),
      //             ),
      //             Icon(Icons.login)
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      // appBar: appBar(
      //   leadingWidget: Builder(
      //       builder: (context) => IconButton(
      //             onPressed: () {
      //               Scaffold.of(context).openDrawer();
      //             },
      //             icon: Icon(Icons.menu),
      //           )),
      //   widget: Text(
      //     "Question Contenet",
      //     style: boldStyle(fontSize: Constant.largeFont, color: firstColor),
      //   ),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //         icon: Icon(Icons.sort),
      //         onPressed: () {
      //           return showButtomSheet();
      //         }),
      //   ],
      // ),
      ,
      body: BlocProvider<CommonQuestionBloc>(
        create: (context) => blocItem,
        child: BlocBuilder<CommonQuestionBloc, CommonQuestionState>(
          builder: (context, state) {
            if (state is LoadingState)
              return LoadingView();
            else if (state is GetAllCommonQuestionSuccess) {
              return ListView(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    (widget.collageId==-1)?  IconButton(
                        icon: Icon(
                          Icons.sort,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ):Container(),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: CommentTextField(
                      cancelUpdate: () {},
                      commentController: searchController,
                      isUpdateClickIcon: false,
                      sendMessage: () {
                        return showButtomSheet();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Wrap(
                      children: state.commonItemsList
                          .map((e) => Padding(
                                padding: EdgeInsets.only(
                                    left: 3, right: 3, bottom: 8, top: 8),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.48,
                                  child: CommonQuestionView(
                                    commonQuestionItem: e,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              );
            } else
              return BlocErrorScreen();
          },
        ),
      ),
    );
  }
}
