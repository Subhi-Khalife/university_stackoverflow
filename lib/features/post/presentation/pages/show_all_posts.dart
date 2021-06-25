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
import 'package:university/features/general_question/presentaion/pages/add_new_post.dart';
import 'package:university/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:university/features/post/presentation/bloc/tabs/tabs_bloc.dart';
import 'package:university/features/post/presentation/pages/add_new_post.dart';
import 'package:university/features/post/presentation/pages/show_post_detail_screen.dart';

class ShowAllPosts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShowAllPosts();
  }
}

class _ShowAllPosts extends State<ShowAllPosts> {
  TabsBloc tabsBloc;
  PostBloc postBloc;
  AdvertismentBloc advertismentBloc;
  ScrollController _scrollController = ScrollController();
  int tabId = 0;

  @override
  void initState() {
    super.initState();
    tabsBloc = TabsBloc();
    postBloc = PostBloc();
    advertismentBloc = AdvertismentBloc();
    advertismentBloc..add(FetchAdvertismentEvent());
    tabsBloc.add(GetAllTaps());
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
                postBloc.add(GetPostForSelectedTags(id: tabId, reloadData: true));
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
                postBloc..add(GetPostForSelectedTags(id: tabId, reloadData: true));
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
      body: BlocProvider<TabsBloc>(
        create: (context) => tabsBloc,
        child: BlocListener<TabsBloc, TabsState>(
          listener: (context, state) {
            if (state is SuccessGetAllTabs) {
              tabId = state.taps[0].id;
              postBloc.add(GetPostForSelectedTags(id: state.taps[0].id));
            }
          },
          child: BlocBuilder<TabsBloc, TabsState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return LoadingView();
              } else if (state is FailedGetAllTabs) {
                return BlocErrorScreen(
                  function: () {
                    tabsBloc.add(GetAllTaps());
                  },
                );
              } else if (state is SuccessGetAllTabs) {
                return BlocProvider<PostBloc>(
                  create: (context) => postBloc,
                  child: BlocBuilder<PostBloc, PostState>(
                    builder: (context, postState) {
                      return Stack(
                        children: [
                          (postState.status == PostsStatus.loading)
                              ? LoadingView()
                              : (postState.status == PostsStatus.failed &&
                                      postState.posts.length != 0)
                                  ? BlocErrorScreen(
                                      function: () {
                                        postBloc.add(GetPostForSelectedTags(id: state.taps[0].id));
                                      },
                                      title: "Error Happened",
                                    )
                                  : showAnswerListItem(postState.posts, postState),
                          Container(
                            height: 40,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: ListView.builder(
                              padding: EdgeInsets.only(left: 4, right: 4, bottom: 10),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 4, right: 4),
                                  child: showListItem(state.taps[index].name, state.taps[index].id),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                              itemCount: state.taps.length,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              } else
                return Container();
            },
          ),
        ),
      ),
    );
  }

  List<String> materialName = ['math', "linear algibra", "algorithm"];
  Widget showAnswerListItem(List<Posts> post, PostState state) {
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
                commentLength: post[index].comments.length,
                description: post[index].description,
                navigatorFunction: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ShowPostDetailScreen(postId: post[index].id)));
                },
                reactsLength: post[index].reacts.length,
                title: post[index].title,
                time: DateFormat('yyyy-MM-dd – KK:mm').format(post[index].createdAt),
                userName: "subhi khalifeh"),
          );
        });
  }

  Widget showListItem(String text, int tabID) {
    return InkWell(
      onTap: () {
        tabId = tabID;
        postBloc..add(GetPostForSelectedTags(id: tabID, reloadData: true));
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
      postBloc..add(GetPostForSelectedTags(id: tabId));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
