import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:university/core/entities/post.dart';
import 'package:university/core/widget/Drawer.dart';
import 'package:university/core/widget/app_bar.dart';
import 'package:university/core/widget/bloc_error_screen.dart';
import 'package:university/core/widget/bottom_loader.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/container_app_decoration.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/core/widget/loading_view.dart';
import 'package:university/features/advertisement/presentation/bloc/bloc/advertisment_bloc.dart';
import 'package:university/features/general_question/data/models/general_questions_model.dart';
import 'package:university/features/general_question/presentaion/bloc/bloc/general_question_bloc.dart';
import 'package:university/features/general_question/presentaion/pages/add_new_post.dart';
import 'package:university/features/post/presentation/pages/add_new_post.dart';
import 'package:university/features/post/presentation/pages/show_post_detail_screen.dart';

class ShowAllGlobalPosts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShowAllGlobalPosts();
  }
}

class _ShowAllGlobalPosts extends State<ShowAllGlobalPosts> {
  GeneralQuestionBloc generalQuestionBloc;
  ScrollController _scrollController = ScrollController();
  int tabId = 0;

  @override
  void initState() {
    super.initState();
    generalQuestionBloc = GeneralQuestionBloc();
    generalQuestionBloc.add(GetAllGlobalPosts(reloadData: true));
    _scrollController.addListener(_onScroll);
  }

  Widget floatingButton() {
    return Builder(
      builder: (BuildContext context) => HawkFabMenu(
        icon: AnimatedIcons.add_event,
        fabColor: Theme.of(context).primaryColor,
        iconColor: Colors.white,
        items: [
          HawkFabMenuItem(
            label: 'Add new post',
            ontap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddNewPostScreen()))
                  .then((value) {
                generalQuestionBloc..add(GetAllGlobalPosts(reloadData: true));
              });
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          HawkFabMenuItem(
            label: 'Global Posts',
            ontap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddNewGlobalPost()))
                  .then((value) {
                generalQuestionBloc..add(GetAllGlobalPosts(reloadData: true));
              });
            },
            icon: Icon(Icons.comment, color: Colors.white),
          ),
        ],
        body: Center(
          child: Text(''),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          widget: Text(
            "Questions",
            style: boldStyle(fontSize: Constant.mediumFont, color: Theme.of(context).hintColor),
          ),
          context: context,
          centerTitle: false,
        ),
        drawer: DrawerItem(),
        floatingActionButton: floatingButton(),
        body: BlocProvider<GeneralQuestionBloc>(
          create: (context) => generalQuestionBloc,
          child: BlocBuilder<GeneralQuestionBloc, GeneralQuestionState>(
            builder: (context, postState) {
              return (postState.status == GeneralQuestionStatus.loading &&
                      postState.posts.length == 0)
                  ? LoadingView()
                  : (postState.status == GeneralQuestionStatus.failed &&
                          postState.posts.length != 0)
                      ? BlocErrorScreen(
                          function: () {},
                          title: "Error Happened",
                        )
                      : showAnswerListItem(postState.posts, postState);
            },
          ),
        ));
  }

  List<String> materialName = ['math', "linear algibra", "algorithm"];

  Widget showAnswerListItem(List<GeneralQuestionsList> post, GeneralQuestionState state) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 30),
        controller: _scrollController,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: state.hasReachedMax ? post.length : post.length + 1,
        itemBuilder: (contxt, index) {
          if (index >= post.length) return BottomLoader();
          return showAnswerCard(post[index]);
        });
  }

  Widget showAnswerCard(GeneralQuestionsList item) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12, right: 8, left: 8),
      child: InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ShowPostDetailScreen(postId: item.id)));
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showTopInfo(),
                  SizedBox(height: 8),
                  Text(
                    item.title,
                    style: boldStyle(
                        fontSize: Constant.largeFont, color: Theme.of(context).primaryColor),
                  ),
                  Html(
                    data: item.title.length > 20 ? item.title.substring(0, 20) : item.title,
                  ),
                  SizedBox(height: 4),
                  showTags(),
                  Divider(),
                  showReaction(item),
                  SizedBox(height: 8),
                ],
              ),
            ),
          )),
    );
  }

  Widget showTags() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: materialName.map((e) {
        return Card(
          elevation: 0,
          color: Colors.grey.shade100,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              e,
              style: lightStyle(fontSize: Constant.mediumFont, color: Colors.black54),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget showTopInfo() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(120),
          child: Container(
            width: 30,
            height: 30,
            color: Colors.red,
          ),
        ),
        SizedBox(width: 4),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "subhi khalifeh",
              style: boldStyle(fontSize: Constant.mediumFont, color: firstColor),
            ),
            Text("4 hours ago", style: boldStyle(fontSize: Constant.smallFont, color: thirdColor)),
          ],
        ),
      ],
    );
  }

  Widget showReaction(GeneralQuestionsList item) {
    return Padding(
      padding: EdgeInsets.only(right: 6, left: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text(item.reacts.length.toString(),
                  style: boldStyle(
                    fontSize: Constant.mediumFont,
                    color: firstColor,
                  )),
              SizedBox(width: 3),
              Text("votes",
                  style: boldStyle(
                    fontSize: Constant.smallFont,
                    color: hintColor,
                  )),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Text(item.comments.length.toString(),
                  style: boldStyle(
                    fontSize: Constant.mediumFont,
                    color: firstColor,
                  )),
              SizedBox(width: 3),
              Text("Answer",
                  style: boldStyle(
                    fontSize: Constant.smallFont,
                    color: hintColor,
                  )),
            ],
          ),
          Spacer(),
          Row(
            children: [
              Text((item.comments.length + 3).toString(),
                  style: boldStyle(
                    fontSize: Constant.mediumFont,
                    color: firstColor,
                  )),
              SizedBox(width: 3),
              Text("Views",
                  style: boldStyle(
                    fontSize: Constant.smallFont,
                    color: hintColor,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget questionReactInfo({String title, int count}) {
    return Container(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              count.toString(),
              style: regularStyle(fontSize: Constant.mediumFont, color: Colors.white70),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: regularStyle(fontSize: Constant.mediumFont, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget showListItem(String text, int tabID) {
    return InkWell(
      onTap: () {
        tabId = tabID;
        generalQuestionBloc..add(GetAllGlobalPosts(reloadData: true));
        print("test data2");
      },
      child: Container(
        decoration: containerDecoration(),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Center(
            child: Text(
              text,
              style: boldStyle(fontSize: Constant.mediumFont, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) {
      generalQuestionBloc..add(GetAllGlobalPosts());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
