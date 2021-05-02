import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/app_button.dart';
import 'package:university/core/widget/bloc_error_screen.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/comment_text_field.dart';
import 'package:university/core/widget/config_screeen.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/core/widget/loading_view.dart';
import 'package:university/features/collage_profile/presentation/pages/new_collage_profile.dart';
import 'package:university/features/common_question/presentation/bloc/common_question/common_question_bloc.dart';
import 'package:university/features/common_question/presentation/widgets/common_question.dart';
import 'package:university/features/login/presentation/pages/login_screen.dart';
import 'package:university/features/sign_up/presentation/pages/sign_up_screen.dart';
import 'package:university/features/university_with_collage/presentation/bloc/bloc/university_bloc.dart';
import 'package:university/features/university_with_collage/presentation/pages/drop_down.dart';

class PublicCommonQuestion extends StatefulWidget {
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
    blocItem = CommonQuestionBloc()..add(GetAllCommonQuestionEvent());
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

  Future showButtomSheet() {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.black,
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
                        fontSize: Constant.mediumFont, color: greyColor),
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
    ConfigScreen configScreen = ConfigScreen(context);
    WidgetSize widgetSize = WidgetSize(configScreen);
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: 52, bottom: 12, left: 8, right: 8),
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Login",
                    style: boldStyle(
                        fontSize: Constant.mediumFont, color: firstColor),
                  ),
                  Icon(Icons.login)
                ],
              ),
            ),
            SizedBox(height: 18),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SignUpScreen(),
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Signup",
                    style: boldStyle(
                        fontSize: Constant.mediumFont, color: firstColor),
                  ),
                  Icon(Icons.login)
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NewCollageProfile(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Collage Profile",
                    style: boldStyle(
                        fontSize: Constant.mediumFont, color: firstColor),
                  ),
                  Icon(Icons.login)
                ],
              ),
            ),
          ],
        ),
      ),
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
                      IconButton(
                        icon: Icon(
                          Icons.sort,
                          size: 30,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // return showButtomSheet();
                          //             onPressed: () {
                          Scaffold.of(context).openDrawer();
                          //             },
                        },
                      ),
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

              // ListView.builder(
              //     padding: EdgeInsets.only(top: 12),
              //     itemBuilder: (context, index) {
              //       return CommonQuestionView(
              //         commonQuestionItem: state.commonItemsList[index],
              //       );
              //     },
              //     itemCount: state.commonItemsList.length);
            } else
              return BlocErrorScreen();
          },
        ),
      ),
    );
  }
}
