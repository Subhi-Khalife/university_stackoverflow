import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:university/core/entities/comment.dart';
import 'package:university/core/widget/app_bar.dart';
import 'package:university/core/widget/bloc_error_screen.dart';
import 'package:university/core/widget/comment_text_field.dart';
import 'package:university/core/widget/comment_widget.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/core/widget/loading_dialog.dart';
import 'package:university/core/widget/loading_view.dart';
import 'package:university/features/comment/presentation/bloc/comment/comment_bloc.dart';
import 'package:university/features/post/presentation/bloc/post/post_bloc.dart';
import 'package:html/dom.dart' as dom;
import 'package:university/features/post/presentation/pages/show_all_replay.dart';

class ShowPostDetailScreen extends StatefulWidget {
  final int postId;
  ShowPostDetailScreen({this.postId});
  @override
  State<StatefulWidget> createState() {
    return _ShowPostDetailScreen();
  }
}

class _ShowPostDetailScreen extends State<ShowPostDetailScreen> {
  PostBloc postBloc;
  CommentBloc commentBloc;
  TextEditingController commentController = TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  ScrollController controller = new ScrollController();
  List<Comment> comments = [];
  int commentId = -1;
  int index = 0;
  ValueNotifier<bool> isUpdate = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    postBloc = PostBloc();
    commentBloc = CommentBloc();
    postBloc.add(GetPostDetail(postId: widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget: Text("Post Info")),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MultiBlocProvider(
            providers: [
              BlocProvider<PostBloc>(
                create: (BuildContext context) => postBloc,
              ),
              BlocProvider<CommentBloc>(
                create: (BuildContext context) => commentBloc,
              ),
            ],
            child: BlocListener<PostBloc, PostState>(
              listener: (context, state) {},
              child: BlocListener<CommentBloc, CommentState>(
                  listener: (context, state) {
                Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                    .pop();
                if (state is SuccessAddNewComment) {
                  commentController.text = "";
                  comments.add(state.addCommentResponse);
                  controller.animateTo(
                    controller.position.maxScrollExtent,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 300),
                  );
                } else if (state is SuccessUpdateComment) {
                  comments[state.index] = state.addCommentResponse;
                  commentId = -1;
                  index = 0;
                  isUpdate.value = false;
                } else if (state is SuccessDeleteComment) {
                  comments.removeAt(state.index);
                }
              }, child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is LoadingPostState) {
                    return LoadingView();
                  } else if (state is FailedGetPostDetail) {
                    return BlocErrorScreen(
                      function: () {
                        postBloc.add(GetPostDetail(postId: widget.postId));
                      },
                    );
                  } else if (state is SuccessGetPostDetail) {
                    comments = state.postDetail.data.comments;
                    return ListView(
                      padding: EdgeInsets.all(8),
                      children: [
                        Text(
                          "${state.postDetail.data.title}",
                          style: boldStyle(
                              fontSize: Constant.largeFont,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Html(
                            data: state.postDetail.data.description,
                            customRender: getCustomRender(),
                          ),
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          children: [
                            SizedBox(height: 8),
                            showReactTitle(state),
                            SizedBox(height: 8),
                            Divider(color: Colors.white),
                            showReactIcons(state),
                            SizedBox(height: 8),
                            showComments(state),
                          ],
                        )
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              )),
            ),
          ),
          BlocProvider<CommentBloc>(
            create: (context) => commentBloc,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ValueListenableBuilder<bool>(
                valueListenable: isUpdate,
                builder: (context, value, _) {
                  return CommentTextField(
                    commentController: commentController,
                    isUpdateClickIcon: value,
                    sendMessage: () {
                      Dialogs.showLoadingDialog(context, _keyLoader);
                      if (commentId == -1)
                        commentBloc.add(
                          AddNewComment(
                            description: commentController.text,
                            postId: widget.postId,
                          ),
                        );
                      else {
                        commentBloc.add(UpdateComment(
                          commentId: commentId,
                          commentIndex: index,
                          description: commentController.text,
                        ));
                      }
                    },
                    cancelUpdate: () {
                      isUpdate.value = false;
                      commentId = -1;
                      index = 0;
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget showComments(SuccessGetPostDetail state) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 40),
          controller: controller,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            int leng = comments[index]?.comments?.length ?? 0;
            return ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                InkWell(
                  onTap: () {},
                  child: CommentWidget(
                    commentItem: CommentItem(
                      description: comments[index].description,
                      function: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) =>
                                    ShowAllReplay(comment: comments[index])))
                            .then((value) {
                          postBloc.add(GetPostDetail(postId: widget.postId));
                        });
                      },
                      imageUrl: comments[index]?.user?.profilePic ?? "",
                      userName: comments[index].user.firstName +
                          comments[index].user.lastName,
                    ),
                    deleteFunction: () {
                      Dialogs.showLoadingDialog(context, _keyLoader);
                      commentBloc.add(DeleteComment(
                          commentId: comments[index].id, commentIndex: index));
                    },
                    updateFunction: () {
                      isUpdate.value = true;
                      commentController.text = comments[index].description;
                      commentId = comments[index].id;
                      index = index;
                    },
                  ),
                ),
                if (leng != 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
                    child: CommentWidget(
                      commentItem: CommentItem(
                          description: comments[index].comments[0].description,
                          imageUrl: comments[index].comments[0].user.profilePic,
                          function: () {},
                          userName: comments[index].comments[0].user.firstName +
                              comments[index].comments[0].user.lastName),
                    ),
                  )
              ],
            );
          },
          itemCount: comments.length,
        );
      },
    );
  }

  Widget showReactIcons(SuccessGetPostDetail state) {
    return Row(
      children: [
        Row(
          children: [
            Icon(Icons.verified_user_outlined, color: Colors.white),
            SizedBox(width: 4),
            Text("usefuls",
                style: boldStyle(
                    fontSize: Constant.largeFont, color: Colors.white))
          ],
        ),
        Spacer(),
        Row(
          children: [
            Icon(Icons.comment, color: Colors.white),
            SizedBox(width: 4),
            Text("Emphases",
                style: boldStyle(
                    fontSize: Constant.largeFont, color: Colors.white))
          ],
        ),
        Spacer(),
        Row(
          children: [
            Icon(Icons.email, color: Colors.white),
            SizedBox(width: 4),
            Text("Comments",
                style: boldStyle(
                    fontSize: Constant.largeFont, color: Colors.white))
          ],
        ),
      ],
    );
  }

  Widget showReactTitle(SuccessGetPostDetail state) {
    return Row(
      children: [
        Text(
          " ${state.postDetail.data.reacts.length} usefuls",
          style:
              regularStyle(fontSize: Constant.mediumFont, color: Colors.white),
        ),
        Text(
          " 0 emphases",
          style:
              regularStyle(fontSize: Constant.mediumFont, color: Colors.white),
        ),
        Spacer(),
        Text(
          " ${state.postDetail.data.comments.length} Comments",
          style:
              regularStyle(fontSize: Constant.mediumFont, color: Colors.white),
        )
      ],
    );
  }

  Map<String, CustomRender> getCustomRender() {
    var customRender = HashMap<String, CustomRender>();
    customRender["img"] = getImageCustomRender;
    return customRender;
  }

  Widget getImageCustomRender(RenderContext context, Widget parsedChild,
      Map<String, String> attributes, dom.Element element) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: new Image.network(
        "${Constant.baseUrl}${attributes["src"]}",
        width: double.infinity,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}
