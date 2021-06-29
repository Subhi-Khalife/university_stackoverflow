import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:university/core/entities/comment.dart';
import 'package:university/core/entities/react.dart';
import 'package:university/core/widget/app_bar.dart';
import 'package:university/core/widget/bloc_error_screen.dart';
import 'package:university/core/widget/comment_text_field.dart';
import 'package:university/core/widget/comment_widget.dart';
import 'package:university/core/widget/constant.dart';
import 'package:university/core/widget/font_style.dart';
import 'package:university/core/widget/loading_dialog.dart';
import 'package:university/core/widget/loading_view.dart';
import 'package:university/core/widget/show_message.dart';
import 'package:university/features/comment/presentation/bloc/comment/comment_bloc.dart';
import 'package:university/features/post/data/models/post_detail_model.dart';
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
  LoadingDialog loading;
  CommentBloc commentBloc;
  TextEditingController commentController = TextEditingController();
  ScrollController controller = new ScrollController();
  List<Comment> comments = [];
  int commentId = -1;
  int selectedIndex = 0;
  ValueNotifier<bool> isUpdate = ValueNotifier(false);
  PostDetailModel postDetailModel;
  @override
  void initState() {
    super.initState();
    postBloc = PostBloc(item: LoadingPostState());
    commentBloc = CommentBloc();
    loading = LoadingDialog(context);
    postBloc.add(GetPostDetail(postId: widget.postId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget: Text("Post Info"), context: context, centerTitle: false),
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
              listener: (context, state) {
                if (state is SuccessGetPostDetail) {
                  postDetailModel = state.postDetail;
                  comments = state.postDetail.data.comments;
                } else if (state is UpdateState) {
                  if (postDetailModel.data.react == null)
                    postDetailModel.data.react = React();
                  else
                    postDetailModel.data.react = null;
                }
              },
              child: BlocListener<CommentBloc, CommentState>(listener: (context, state) {
                if (state is LoadingState) {
                } else if (state is SuccessAddNewComment) {
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
                  selectedIndex = 0;
                  isUpdate.value = false;
                } else if (state is SuccessDeleteComment) {
                  loading.dismiss(context);
                  comments.removeAt(state.index);
                } else if (state is InvalidCommentState) {
                  loading.dismiss(context);
                  showMessage(state.message);
                } else {
                  loading.dismiss(context);
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
                  } else
                    return ListView(
                      padding: EdgeInsets.all(8),
                      children: [
                        Text(
                          "${postDetailModel.data.title}",
                          style: boldStyle(fontSize: Constant.largeFont, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4))),
                          child: Html(
                            data: postDetailModel.data.description,
                            customRender: getCustomRender(),
                          ),
                        ),
                        SizedBox(height: 10),
                        ListView(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          children: [
                            SizedBox(height: 8),
                            showReactTitle(),
                            SizedBox(height: 8),
                            Divider(color: Colors.white),
                            showReactIcons(),
                            SizedBox(height: 8),
                            showComments(),
                          ],
                        )
                      ],
                    );
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
                      if (commentController.text.trim().length == 0) {
                      } else {
                        FocusScope.of(context).unfocus();
                        loading.show(context);
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
                            commentIndex: selectedIndex,
                            description: commentController.text,
                          ));
                        }
                      }
                    },
                    cancelUpdate: () {
                      isUpdate.value = false;
                      commentId = -1;
                      selectedIndex = 0;
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

  Widget showComments() {
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
              padding: EdgeInsets.only(top: 12),
              children: [
                InkWell(
                  onTap: () {},
                  child: CommentWidget(
                    commentItem: CommentItem(
                      description: comments[index].description,
                      function: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => ShowAllReplay(comment: comments[index])))
                            .then((value) {
                          postBloc.add(GetPostDetail(postId: widget.postId));
                        });
                      },
                      imageUrl: comments[index]?.user?.profilePic ?? "",
                      userName: comments[index].user.firstName+" "+ comments[index].user.lastName,
                    ),
                    deleteFunction: () {
                      loading.show(context);
                      commentBloc
                          .add(DeleteComment(commentId: comments[index].id, commentIndex: index));
                    },
                    updateFunction: () {
                      isUpdate.value = true;
                      commentController.text = comments[index].description;
                      commentId = comments[index].id;
                      selectedIndex = index;
                    },
                  ),
                ),
                if (leng != 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 24, top: 4, bottom: 4),
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

  Widget showReactIcons() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            postBloc.add(SetReact(postId: postDetailModel.data.id));
          },
          child: Row(
            children: [
              Icon(Icons.verified_user_outlined,
                  color: postDetailModel.data.react != null ? Colors.white : Colors.blue),
              SizedBox(width: 4),
              Text("usefuls",
                  style:
                      boldStyle(fontSize: Constant.smallFont, color: Theme.of(context).hintColor))
            ],
          ),
        ),
        Spacer(),
         Row(
          children: [
            Icon(Icons.share, color: Theme.of(context).hintColor),
            SizedBox(width: 4),
            Text("Share",
                style: boldStyle(fontSize: Constant.smallFont, color: Theme.of(context).hintColor))
          ],
        ),
        Spacer(),
        Row(
          children: [
            Icon(Icons.email, color: Theme.of(context).hintColor),
            SizedBox(width: 4),
            Text("Comments",
                style: boldStyle(fontSize: Constant.smallFont, color: Theme.of(context).hintColor))
          ],
        ),
      ],
    );
  }

  Widget showReactTitle() {
    return Row(
      children: [
        Text(
          " ${postDetailModel.data.reacts.length} Usefuls Votes",
          style: regularStyle(fontSize: Constant.smallFont, color: Theme.of(context).hintColor),
        ),
        SizedBox(width: 10),
        
        Spacer(),
        Text(
          " ${postDetailModel.data.comments.length} Comments",
          style: regularStyle(fontSize: Constant.smallFont, color: Theme.of(context).hintColor),
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
      child: new Image.network(
        "${Constant.imageUrl}${attributes["src"]}",
        width: double.infinity,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}
