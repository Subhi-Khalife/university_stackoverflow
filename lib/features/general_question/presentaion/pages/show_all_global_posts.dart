import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:intl/intl.dart';
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
import 'package:university/core/widget/question_list_item.dart';
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
          return QuestionListItem(
            questionListItemParam: QuestionListItemParam(
                description: post[index].description,
                imageUrl: post[index]?.user?.profilePic??"",
                commentLength: post[index].comments.length,
                tapTitle: "Public Question ",
                navigatorFunction: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShowPostDetailScreen(postId: post[index].id)));
                },
                reactsLength: post[index].reacts.length,
                title: post[index].title,
                time: DateFormat('yyyy-MM-dd – KK:mm')
                    .format(post[index]?.createdAt ?? DateTime.now()),
                userName: post[index].user.firstName + "  " + post[index].user.lastName),
          );
        });
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
