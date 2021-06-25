part of 'post_bloc.dart';

abstract class PostEvent {
  const PostEvent();
}

class AddNewPost extends PostEvent {
  final String title;
  final String description;
  final int tapID;
  final int subjectID;
  AddNewPost({
    this.description,
    this.tapID = -1,
    this.title,
    this.subjectID = -1,
  });
}

class GetPostForSelectedTags extends PostEvent {
  final int id;
  final bool reloadData;
  GetPostForSelectedTags({this.id,this.reloadData=false});
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

class SetReact extends PostEvent{
  final int postId;
  SetReact({this.postId});
}