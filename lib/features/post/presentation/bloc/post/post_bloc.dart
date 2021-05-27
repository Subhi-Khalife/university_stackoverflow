import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/entities/post.dart';
import 'package:university/core/error/exception.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/common_question/presentation/bloc/common_question/common_question_bloc.dart';
import 'package:university/features/post/data/models/get_all_replayes_model.dart';
import 'package:university/features/post/data/models/post_detail_model.dart';
import 'package:university/features/post/data/models/posts_model.dart';
import 'package:university/features/post/data/repositories/post_repositories_impl.dart';
import 'package:university/features/post/domain/usecases/get_all_post_replayes.dart';
import 'package:university/features/post/domain/usecases/get_post_detail.dart';
import 'package:university/features/post/domain/usecases/get_posts_for_selected_tag.dart';
import 'package:university/features/post/domain/usecases/set_new_post.dart';
import 'package:university/features/post/domain/usecases/upload_image.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostState());
  UseCase addNewPost =
      SetNewPost(postRepositories: PostRepositoriesImplementation());
  UseCase getPostsByTap = GetPostsForSelectedTags(
      postRepositories: PostRepositoriesImplementation());
  UseCase<String, File> uploadImage =
      UploadImageUseCase(postRepositories: PostRepositoriesImplementation());
  UseCase<PostDetailModel, GetPostDetailParam> getPostDetails =
      GetPostDetailUseCase(postRepositories: PostRepositoriesImplementation());
  UseCase<GetAllReplayesModel, GetAllPostReplayesParam>
      getAllPostReplayesUseCase = GetAllPostReplayesUseCase(
          postRepositories: PostRepositoriesImplementation());
  @override

  ///GetAllPostReplayesUseCase
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is AddNewPost) {
      yield* _mapAddNewPost(event);
    } else if (event is GetPostForSelectedTags) {
      yield* _mapGetPostForSelectedTags(event);
    } else if (event is UploadImage) {
      yield* _mapUploadImage(event);
    } else if (event is RemoveImageFromlistEvent) {
      yield RemoveImageFromlist(index: event.index);
    } else if (event is GetPostDetail) {
      yield* _mapGetPostDetail(event);
    } else if (event is GetAllPostReplay) {
      yield* _mapGetAllPostReplay(event);
    }
  }

  Stream<PostState> _mapGetAllPostReplay(GetAllPostReplay event) async* {
    yield LoadingPostState();
    Either<Failure, GetAllReplayesModel> result =
        await getAllPostReplayesUseCase(
            GetAllPostReplayesParam(commentId: event.commentId));
    yield result.fold((failure) {
      if (failure is MissingParamException)
        return FailedUploadImage();
      else {
        return FailedUploadImage();
      }
    }, (body) {
      return SuccessGetAllReplayes(allReplayesModel: body);
    });
  }

  Stream<PostState> _mapGetPostDetail(GetPostDetail event) async* {
    yield LoadingPostState();
    Either<Failure, PostDetailModel> result =
        await getPostDetails(GetPostDetailParam(postID: event.postId));
    yield result.fold((failure) {
      if (failure is MissingParamException)
        return FailedUploadImage();
      else {
        return FailedUploadImage();
      }
    }, (body) {
      return SuccessGetPostDetail(postDetail: body);
    });
  }

  Stream<PostState> _mapUploadImage(UploadImage event) async* {
    // yield state.copyWith(status: PostsStatus.loading);
    yield LoadingPostState();
    Either<Failure, String> result = await uploadImage(event.imageFile);
    yield result.fold((failure) {
      if (failure is MissingParamException)
        return FailedUploadImage();
      else {
        return FailedUploadImage();
      }
    }, (body) {
      return SuccessUploadImage(image: body);
    });
  }

  Stream<PostState> _mapGetPostForSelectedTags(
      GetPostForSelectedTags event) async* {
    yield state.copyWith(status: PostsStatus.loading);
    Either<Failure, PostsModel> result =
        await getPostsByTap(GetPostsForSelectedTagsParams(tabId: event.id));
    yield result.fold((failure) {
      if (failure is MissingParamException)
        return state.copyWith(status: PostsStatus.failed);
      else {
        return state.copyWith(status: PostsStatus.failed);
      }
    }, (body) {
      return state.copyWith(status: PostsStatus.success, posts: body.data.data);
    });
  }

  Stream<PostState> _mapAddNewPost(AddNewPost event) async* {
    Either<Failure, NewPosts> result = await addNewPost(SetNewPostParam(
        description: event.description,
        tapID: event.tapID,
        title: event.title));
    yield result.fold((failure) {
      if (failure is MissingParamException)
        return AddNewPostFailed();
      else {
        return AddNewPostFailed();
      }
    }, (body) {
      return AddNewPostSuccess();
    });
  }
}
