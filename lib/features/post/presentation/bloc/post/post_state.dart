part of 'post_bloc.dart';

enum PostsStatus { failed, initail, success, loading }

class PostState {
  PostsStatus status;
  List<Posts> posts;
  bool hasReachedMax;
  PostState({
    this.status = PostsStatus.initail,
    this.posts = const <Posts>[],
    this.hasReachedMax = false,
  });

  copyWith({PostsStatus status, List<Posts> posts, bool hasReachedMax}) {
    return PostState(
        status: (status) ?? this.status,
        posts: (posts) ?? this.posts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
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

class InvalidState extends PostState {
  final String errorMessage;
  InvalidState({this.errorMessage});
}

class SuccessChangeReact extends PostState {}

class FailedChangeReact extends PostState {}

class UpdateState extends PostState {}