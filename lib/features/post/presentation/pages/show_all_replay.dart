import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class ShowAllReplay extends StatefulWidget {
  final Comment comment;
  ShowAllReplay({@required this.comment});
  @override
  State<StatefulWidget> createState() {
    return _ShowAllReplay();
  }
}

class _ShowAllReplay extends State<ShowAllReplay> {
  PostBloc postBloc;
  CommentBloc commentBloc;
  TextEditingController commentController = TextEditingController();
  LoadingDialog loading;
  ScrollController controller = new ScrollController();
  List<Comment> comments = [];
  int commentId = -1;
  int index = 0;
  ValueNotifier<bool> isUpdate = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    commentBloc = CommentBloc();
    postBloc = PostBloc();
    postBloc.add(GetAllPostReplay(commentId: widget.comment.id));
    loading = LoadingDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget: Text("All Replay"), context: context),
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
            child: BlocListener<CommentBloc, CommentState>(listener: (context, state) {
              //
              if (state is SuccessAddNewComment) {
                loading.dismiss(context);
                commentController.text = "";
                comments.add(state.addCommentResponse);
                controller.animateTo(
                  controller.position.maxScrollExtent,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );
              } else if (state is SuccessUpdateComment) {
                loading.dismiss(context);
                comments[state.index] = state.addCommentResponse;
                commentId = -1;
                index = 0;
                isUpdate.value = false;
              } else if (state is SuccessDeleteComment) {
                loading.dismiss(context);
                comments.removeAt(state.index);
              }
            }, child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is LoadingPostState) {
                  return LoadingView();
                } else if (state is FailedGetPostDetail) {
                  return BlocErrorScreen(
                    function: () {
                      // postBloc.add(GetPostDetail(postId: widget.postId));
                    },
                  );
                } else if (state is SuccessGetAllReplayes) {
                  comments = state.allReplayesModel.data;
                  print("the comment legth is ${comments.length}");
                  return ListView(
                    padding: const EdgeInsets.all(4),
                    children: [
                      CommentWidget(
                        commentItem: CommentItem(
                          description: widget.comment.description,
                          function: () {},
                          imageUrl: widget?.comment?.user?.profilePic ?? "",
                          userName: widget.comment.user.firstName + widget.comment.user.lastName,
                        ),
                        withPopMenu: false,
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        children: [
                          SizedBox(height: 8),
                          // showReactTitle(state),
                          SizedBox(height: 8),
                          Divider(color: Colors.white),
                          // showReactIcons(state),
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
                      if (commentController.text.trim().length == 0) {
                      } else {
                        FocusScope.of(context).unfocus();
                        loading.show(context);
                        if (commentId == -1)
                          commentBloc.add(
                            AddNewComment(
                              description: commentController.text,
                              commentId: widget.comment.id,
                            ),
                          );
                        else {
                          print("the index value si $index");
                          commentBloc.add(UpdateComment(
                            commentId: commentId,
                            commentIndex: index,
                            description: commentController.text,
                          ));
                        }
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

  Widget showComments(SuccessGetAllReplayes state) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        return ListView.builder(
          padding: EdgeInsets.only(bottom: 40),
          controller: controller,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CommentWidget(
                    commentItem: CommentItem(
                        description: comments[index].description,
                        imageUrl: comments[index]?.user?.profilePic ?? "",
                        function: () {},
                        userName: comments[index]?.user?.firstName ??
                            "" + comments[index]?.user?.lastName ??
                            ""),
                    deleteFunction: () {
                      loading.show(context);
                      commentBloc
                          .add(DeleteComment(commentId: comments[index].id, commentIndex: index));
                    },
                    updateFunction: () {
                      isUpdate.value = true;
                      commentController.text = comments[index].description;
                      commentId = comments[index].id;
                      this.index = index;
                    },
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
            Text("usefuls", style: boldStyle(fontSize: Constant.largeFont, color: Colors.white))
          ],
        ),
        Spacer(),
        Row(
          children: [
            Icon(Icons.comment, color: Colors.white),
            SizedBox(width: 4),
            Text("Emphases", style: boldStyle(fontSize: Constant.largeFont, color: Colors.white))
          ],
        ),
        Spacer(),
        Row(
          children: [
            Icon(Icons.email, color: Colors.white),
            SizedBox(width: 4),
            Text("Comments", style: boldStyle(fontSize: Constant.largeFont, color: Colors.white))
          ],
        ),
      ],
    );
  }

  // Widget showReactTitle(SuccessGetAllReplayes state) {
  //   return Row(
  //     children: [
  //       Text(
  //         " ${state.postDetail.data.reacts.length} usefuls",
  //         style:
  //             regularStyle(fontSize: Constant.mediumFont, color: Colors.white),
  //       ),
  //       Text(
  //         " 0 emphases",
  //         style:
  //             regularStyle(fontSize: Constant.mediumFont, color: Colors.white),
  //       ),
  //       Spacer(),
  //       Text(
  //         " ${state.postDetail.data.comments.length} Comments",
  //         style:
  //             regularStyle(fontSize: Constant.mediumFont, color: Colors.white),
  //       )
  //     ],
  //   );
  // }

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
        "${Constant.imageUrl}${attributes["src"]}",
        width: double.infinity,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}
