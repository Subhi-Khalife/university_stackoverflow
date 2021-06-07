import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/entities/post.dart';
import 'package:university/core/widget/Drawer.dart';
import 'package:university/core/widget/app_bar.dart';
import 'package:university/core/widget/bloc_error_screen.dart';
import 'package:university/core/widget/cached_newtwok_image_view.dart';
import 'package:university/core/widget/colors.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/container_app_decoration.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/core/widget/loading_view.dart';
import 'package:university/features/advertisement/presentation/bloc/bloc/advertisment_bloc.dart';
import 'package:university/features/collage_profile/presentation/pages/new_collage_profile.dart';
import 'package:university/features/collage_profile/presentation/pages/profile_page.dart';
import 'package:university/features/feedback/presentation/pages/feedback_screen.dart';
import 'package:university/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:university/features/post/presentation/bloc/tabs/tabs_bloc.dart';
import 'package:university/features/post/presentation/pages/add_new_post.dart';
import 'package:university/features/post/presentation/pages/show_post_detail_screen.dart';
import 'package:university/features/splash_screen/presentation/pages/splash_screen.dart';

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
  @override
  void initState() {
    super.initState();
    tabsBloc = TabsBloc();
    postBloc = PostBloc();
    advertismentBloc = AdvertismentBloc();
    advertismentBloc..add(FetchAdvertismentEvent());
    tabsBloc.add(GetAllTaps());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        widget: Text(
          "Questions",
          style: boldStyle(
              fontSize: Constant.mediumFont,
              color: Theme.of(context).hintColor),
        ),
        context: context,
        centerTitle: false,
      ),
      drawer: DrawerItem(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddNewPostScreen()))
              .then((value) {
            tabsBloc.add(GetAllTaps());
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
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
                      return Stack(
                        children: [
                          ListView(
                            padding: EdgeInsets.only(top: 50),
                            children: [
                              // BlocProvider(
                              //   create: (context) => advertismentBloc,
                              //   child: BlocBuilder<AdvertismentBloc,
                              //       AdvertismentState>(
                              //     builder: (context, state) {
                              //       if (state is SuccessGettingAdsState) {
                              //         final successAds =
                              //             state.advertisementModel.data;
                              //         return Container(
                              //           height: 75,
                              //           color: Colors.white,
                              //           child: Swiper(
                              //             autoplay: true,
                              //             itemCount: successAds.length,
                              //             itemBuilder: (context, index) {
                              //               return Image.network(
                              //                 successAds[index].imageUrl,
                              //                 fit: BoxFit.fitWidth,
                              //               );
                              //             },
                              //           ),
                              //         );
                              //       } else {
                              //         return Container(
                              //           color: Colors.red,
                              //         );
                              //       }
                              //     },
                              //   ),
                              // ),
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
                          Container(
                            height: 40,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                  left: 4, right: 4, bottom: 10),
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
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12, right: 8, left: 8),
      child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowPostDetailScreen(postId: item.id)));
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
                        fontSize: Constant.largeFont,
                        color: Theme.of(context).primaryColor),
                  ),
                  Html(
                    data: item.title.length > 20
                        ? item.title.substring(0, 20)
                        : item.title,
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
              style: lightStyle(
                  fontSize: Constant.mediumFont, color: Colors.black54),
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
              style:
                  boldStyle(fontSize: Constant.mediumFont, color: firstColor),
            ),
            Text("4 hours ago",
                style:
                    boldStyle(fontSize: Constant.smallFont, color: thirdColor)),
          ],
        ),
      ],
    );
  }

  Widget showReaction(Posts item) {
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
              style: regularStyle(
                  fontSize: Constant.mediumFont, color: Colors.white70),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: regularStyle(
                  fontSize: Constant.mediumFont, color: Colors.white70),
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
