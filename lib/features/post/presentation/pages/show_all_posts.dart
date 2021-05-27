import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:university/core/entities/post.dart';
import 'package:university/core/widget/FontFamily.dart';
import 'package:university/core/widget/bloc_error_screen.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/container_app_decoration.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/core/widget/loading_view.dart';
import 'package:university/features/post/data/models/posts_model.dart';
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
  @override
  void initState() {
    super.initState();
    tabsBloc = TabsBloc();
    postBloc = PostBloc();
    tabsBloc.add(GetAllTaps());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddNewPostScreen(
                    title: "Add new post",
                  )));
        },
        child: Icon(Icons.add),
        backgroundColor: colorThemApp,
      ),
      body: BlocProvider<TabsBloc>(
        create: (context) => tabsBloc,
        child: BlocListener<TabsBloc, TabsState>(
          listener: (context, state) {
            if (state is SuccessGetAllTabs) {
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
                      return Padding(
                        padding: EdgeInsets.only(top: 38),
                        child: ListView(
                          children: [
                            Container(
                              height: 40,
                              child: ListView.builder(
                                padding: EdgeInsets.only(left: 4, right: 4),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 4, right: 4),
                                    child: showListItem(state.taps[index].name,
                                        state.taps[index].id),
                                  );
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: state.taps.length,
                              ),
                            ),
                            (postState.status == PostsStatus.loading)
                                ? LoadingView()
                                : (postState.status == PostsStatus.failed)
                                    ? BlocErrorScreen(
                                        function: () {
                                          postBloc.add(GetPostForSelectedTags(
                                              id: state.taps[0].id));
                                        },
                                        title: "Error Happened",
                                      )
                                    : showListOfItem(postState.posts)
                          ],
                        ),
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

  Widget showListOfItem(List<Posts> post) {
    return ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: post.length,
        itemBuilder: (contxt, index) {
          return showAnswerCard(post[index]);
        });
  }

  Widget showAnswerCard(Posts item) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ShowPostDetailScreen(postId: item.id)));
      },
      child: Padding(
        padding: EdgeInsets.only(right: 6, left: 6, top: 8),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                questionReactInfo(
                    title: 'votes', count: (item?.ratesSumRate ?? 0)),
                questionReactInfo(
                    title: 'answer', count: (item?.comments?.length ?? 0)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.title,
                          style: regularStyle(
                            fontSize: Constant.mediumFont,
                            color: colorThemApp,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
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
              style: regularStyle(
                  fontSize: Constant.mediumFont, color: secondColor),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: regularStyle(
                  fontSize: Constant.mediumFont, color: secondColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget showListItem(String text, int tabID) {
    return InkWell(
      onTap: () {
        postBloc.add(GetPostForSelectedTags(id: tabID));
      },
      child: Container(
        decoration: containerDecoration(),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Center(
            child: Text(
              text,
              style:
                  boldStyle(fontSize: Constant.mediumFont, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
