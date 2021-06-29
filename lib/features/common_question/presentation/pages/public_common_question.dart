import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university/core/widget/Drawer.dart';
import 'package:university/core/widget/FontFamily.dart';
import 'package:university/core/widget/app_bar.dart';
import 'package:university/core/widget/bottom_loader.dart';
import 'package:university/core/widget/container_app_decoration.dart';
import 'package:university/features/common_question/presentation/bloc/common_question/common_question_bloc.dart';

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
  int collageId;
  bool needShowButtomSheet;
  PublicCommonQuestion({this.collageId = -1, this.needShowButtomSheet = true});
  @override
  State<StatefulWidget> createState() {
    return _PublicCommonQuestion();
  }
}

class _PublicCommonQuestion extends State<PublicCommonQuestion> with TickerProviderStateMixin {
  CommonQuestionBloc blocItem;
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    if (widget.collageId == -1)
      blocItem = CommonQuestionBloc()..add(GetAllCommonQuestionEvent());
    else
      blocItem = CommonQuestionBloc()
        ..add(GetAllCommonQuestionForSelectedCollageEvent(collageId: widget.collageId.toString()));
    if (widget.collageId == -1 && widget.needShowButtomSheet)
      Future.delayed(Duration(seconds: 0)).then((_) {
        beginBottomSheet();
      });
  }

  @override
  void dispose() {
    super.dispose();
    blocItem.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget: Text("Common Question"), context: context),
      drawer: (widget.collageId == -1) ? DrawerItem() : null,
      body: BlocProvider<CommonQuestionBloc>(
        create: (context) => blocItem,
        child: BlocBuilder<CommonQuestionBloc, CommonQuestionState>(
          builder: (context, state) {
            if (state.status == CommonQuestionStatus.loading ||
                state.status == CommonQuestionStatus.inital)
              return LoadingView();
            else if (state.status == CommonQuestionStatus.error) {
              if (state.commonItemsList.length != 0) return showInfo(state);
              return BlocErrorScreen(
                title: "Error Happened try again",
                function: () {},
              );
            } else if (state.status == CommonQuestionStatus.success) {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 18, right: 18),
                    child: CommentTextField(
                      cancelUpdate: () {},
                      commentController: searchController,
                      isUpdateClickIcon: false,
                      title: "Filter your search",
                      iconData: Icons.sort,
                      readOnly: true,
                      sendMessage: () {
                        return showButtomSheet();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: showInfo(state),
                  )
                ],
              );
            } else
              return BlocErrorScreen();
          },
        ),
      ),
    );
  }
  // Column(
  //   mainAxisSize: MainAxisSize.min,
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   mainAxisAlignment: MainAxisAlignment.start,
  //   children: [
  //     (widget.collageId == -1)
  //         ? IconButton(
  //             icon: Icon(
  //               Icons.sort,
  //               size: 30,
  //               color: Colors.white,
  //             ),
  //             onPressed: () {
  //               Scaffold.of(context).openDrawer();
  //             },
  //           )
  //         : Container(),
  //   ],
  // ),
  // Padding(
  //   padding: EdgeInsets.only(left: 18, right: 18),
  //   child: CommentTextField(
  //     cancelUpdate: () {},
  //     commentController: searchController,
  //     isUpdateClickIcon: false,
  //     sendMessage: () {
  //       return showButtomSheet();
  //     },
  //   ),
  // ),

  Widget showInfo(CommonQuestionState state) {
    print("state asasa${state.hasReachedMax}");
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: GridView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          if (index >= state.commonItemsList.length) {
            return BottomLoader();
          }
          return Padding(
            padding: EdgeInsets.only(left: 3, right: 3, bottom: 8, top: 8),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.48,
              child: CommonQuestionView(
                commonQuestionItem: state.commonItemsList[index],
              ),
            ),
          );
        },
        itemCount:
            (state.hasReachedMax) ? state.commonItemsList.length : state.commonItemsList.length + 1,
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

  Future beginBottomSheet() {
    ValueNotifier<bool> checkBox = ValueNotifier(false);
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
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
                              fontSize: Constant.largeFont, color: Theme.of(context).accentColor),
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
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => LoginScreen()));
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
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
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
                              fillColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
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
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      enableDrag: true,
      builder: (BuildContext context) {
        return BlocProvider<UniversityBloc>(
          create: (context) => UniversityBloc()..add(FetchUiversity()),
          child: BlocBuilder<UniversityBloc, UniversityState>(builder: (context, state) {
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
                      widget.collageId = state.collageId;
                      blocItem.add(GetAllCommonQuestionForSelectedCollageEvent(
                          collageId: state.collageId.toString(), reloadData: true));
                      Navigator.of(context).pop();
                    },
                    name: "Search",
                    buttonColor: Theme.of(context).primaryColor,
                    fontColor: Theme.of(context).accentColor)
              ],
            );
          }),
        );
      },
    );
  }

  void _onScroll() {
    if (_isBottom) {
      if (widget.collageId == -1)
        blocItem.add(GetAllCommonQuestionEvent());
      else
        blocItem.add(
            GetAllCommonQuestionForSelectedCollageEvent(collageId: widget.collageId.toString()));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
