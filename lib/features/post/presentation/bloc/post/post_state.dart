part of 'post_bloc.dart';

enum PostsStatus { failed, initail, success, loading }

class PostState {
  PostsStatus status;
  List<Posts> posts;
  PostState({
    this.status = PostsStatus.initail,
    this.posts = const <Posts>[],
  });

  copyWith({PostsStatus status, List<Posts> posts}) {
    return PostState(
        status: (status) ?? this.status, posts: (posts) ?? this.posts);
  }
}

class AddNewPostFailed extends PostState {}

class AddNewPostSuccess extends PostState {}

class LoadingPostState extends PostState {}

class FailedUploadImage extends PostState {}

class SuccessUploadImage extends PostState {
  final String image;
  SuccessUploadImage({this.image});
}

class RemoveImageFromlist extends PostState {
  int index;
  RemoveImageFromlist({this.index});
}

class FailedGetPostDetail extends PostState {}

class SuccessGetPostDetail extends PostState {
  final PostDetailModel postDetail;
  SuccessGetPostDetail({this.postDetail});
}

class SuccessGetAllReplayes extends PostState {
  final GetAllReplayesModel allReplayesModel;
  SuccessGetAllReplayes({this.allReplayesModel});
}
