import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/app_bar.dart';
import '../../../../core/widget/app_button.dart';
import '../../../../core/widget/bloc_error_screen.dart';
import '../../../../core/widget/colors.dart';
import '../../../../core/widget/config_screeen.dart';
import '../../../../core/widget/constant.dart';
import '../../../../core/widget/font_style.dart';
import '../../../../core/widget/loading_view.dart';
import '../../../login/presentation/pages/login_screen.dart';
import '../../../sign_up/presentation/pages/sign_up_screen.dart';
import '../../../university_with_collage/presentation/bloc/bloc/university_bloc.dart';
import '../../../university_with_collage/presentation/pages/drop_down.dart';
import '../bloc/common_question/common_question_bloc.dart';
import '../widgets/common_question.dart';

class PublicCommonQuestion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PublicCommonQuestion();
  }
}

class _PublicCommonQuestion extends State<PublicCommonQuestion>
    with TickerProviderStateMixin {
  CommonQuestionBloc blocItem;
  @override
  void initState() {
    super.initState();
    blocItem = CommonQuestionBloc()..add(GetAllCommonQuestionEvent());
    // appBar = AppBarRestaurant(
    //     context: context,
    //     title: "Common Question",
    //     appColor: colorThemApp,
    //     centerTitle: true,
    //     backIcon: false,
    //     leadingWidget: IconButton(
    //       onPressed: () {
    //         Scaffold.of(context).openDrawer();
    //       },
    //       icon: Icon(Icons.menu),
    //     ),
    //     actions: [
    //       IconButton(
    //           icon: Icon(Icons.sort),
    //           onPressed: () {
    //             return showButtomSheet();
    //           }),
    //     ]);
  }

  Widget dropDownCollage() {
    return BlocListener<UniversityBloc, UniversityState>(
      listener: (context, state) {},
      child: BlocBuilder<UniversityBloc, UniversityState>(
        builder: (context, state) {
          if (state is UniversityState) {
            return Column(
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
      builder: (BuildContext context) {
        return BlocProvider<UniversityBloc>(
          create: (context) => UniversityBloc()..add(FetchUiversity()),
          child: BlocBuilder<UniversityBloc, UniversityState>(
              builder: (context, state) {
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Search common question to selected university",
                    style: boldStyle(
                        fontSize: Constant.xlargeFont, color: colorThemApp),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "if use this type of search you show all common question that related for this university and country",
                    style: boldStyle(
                        fontSize: Constant.mediumFont, color: secondColor),
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
            )
          ],
        ),
      ),
      appBar: appBar(
        leadingWidget: Builder(
            builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu),
                )),
        widget: Text(
          "Question Contenet",
          style: boldStyle(fontSize: Constant.largeFont, color: firstColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.sort),
              onPressed: () {
                return showButtomSheet();
              }),
        ],
      ),
      body: BlocProvider<CommonQuestionBloc>(
        create: (context) => blocItem,
        child: BlocBuilder<CommonQuestionBloc, CommonQuestionState>(
          builder: (context, state) {
            if (state is LoadingState)
              return LoadingView();
            else if (state is GetAllCommonQuestionSuccess) {
              return ListView.builder(
                  padding: EdgeInsets.only(top: 12),
                  itemBuilder: (context, index) {
                    return CommonQuestionView(
                      commonQuestionItem: state.commonItemsList[index],
                    );
                  },
                  itemCount: state.commonItemsList.length);
            } else
              return BlocErrorScreen();
          },
        ),
      ),
    );
  }
}
