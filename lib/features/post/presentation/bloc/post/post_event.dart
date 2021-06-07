part of 'post_bloc.dart';

abstract class PostEvent  {
  const PostEvent();

}

class AddNewPost extends PostEvent {
  final String title;
  final String description;
  final int tapID;
  AddNewPost({this.description, this.tapID, this.title});
}

class GetPostForSelectedTags extends PostEvent {
  final int id;
  GetPostForSelectedTags({this.id});
}

class UploadImage extends PostEvent {
  final File imageFile;
  UploadImage({this.imageFile});
}

class RemoveImageFromlistEvent extends PostEvent {
  final int index;
  RemoveImageFromlistEvent({this.index});
}

class GetPostDetail extends PostEvent {
  final int postId;
  GetPostDetail({this.postId});
}

class GetAllPostReplay extends PostEvent {
  final int commentId;
  GetAllPostReplay({this.commentId});
}
