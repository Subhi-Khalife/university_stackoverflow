import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/entities/new_posts.dart';
import 'package:university/core/entities/post.dart';
import 'package:university/core/entities/user.dart';
import 'package:university/core/error/exception.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/common_question/presentation/bloc/common_question/common_question_bloc.dart';
import 'package:university/features/post/data/models/get_all_replayes_model.dart';
import 'package:university/features/post/data/models/post_detail_model.dart';
import 'package:university/features/post/data/models/posts_model.dart';
import 'package:university/features/post/data/repositories/post_repositories_impl.dart';
import 'package:university/features/post/domain/usecases/get_all_post_replayes.dart';
import 'package:rxdart/rxdart.dart';
import 'package:university/features/post/domain/usecases/get_post_detail.dart';
import 'package:university/features/post/domain/usecases/get_posts_for_selected_tag.dart';
import 'package:university/features/post/domain/usecases/set_new_post.dart';
import 'package:university/features/post/domain/usecases/set_react.dart';
import 'package:university/features/post/domain/usecases/upload_image.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final int pageSize = 20;
  PostState item;
  PostBloc({this.item}) : super(item ?? PostState());
  UseCase addNewPost = SetNewPost(postRepositories: PostRepositoriesImplementation());
  UseCase getPostsByTap =
      GetPostsForSelectedTags(postRepositories: PostRepositoriesImplementation());
  UseCase<String, File> uploadImage =
      UploadImageUseCase(postRepositories: PostRepositoriesImplementation());
  UseCase<PostDetailModel, GetPostDetailParam> getPostDetails =
      GetPostDetailUseCase(postRepositories: PostRepositoriesImplementation());
  UseCase<GetAllReplayesModel, GetAllPostReplayesParam> getAllPostReplayesUseCase =
      GetAllPostReplayesUseCase(postRepositories: PostRepositoriesImplementation());
  UseCase<bool, SetReactParam> setNewReact =
      SetNewReactUseCase(postRepositories: PostRepositoriesImplementation());
  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
    Stream<PostEvent> events,
    TransitionFunction<PostEvent, PostState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 200)),
      transitionFn,
    );
  }

  @override
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
    } else if (event is SetReact) {
      yield* _mapSetReact(event);
    }
  }

  Stream<PostState> _mapSetReact(SetReact event) async* {
    yield UpdateState();
    Either<Failure, bool> result = await setNewReact(SetReactParam(postId: event.postId));
    yield result.fold((failure) {
      if (failure is MissingParamException)
        return FailedChangeReact();
      else {
        return FailedChangeReact();
      }
    }, (body) {
      return SuccessChangeReact();
    });
  }

  Stream<PostState> _mapGetAllPostReplay(GetAllPostReplay event) async* {
    yield LoadingPostState();
    Either<Failure, GetAllReplayesModel> result =
        await getAllPostReplayesUseCase(GetAllPostReplayesParam(commentId: event.commentId));
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

  Stream<PostState> _mapGetPostForSelectedTags(GetPostForSelectedTags event) async* {
    try {
      if (state.hasReachedMax && !event.reloadData) {
        yield state;
        return;
      }
      if (event.reloadData) {
        yield state.copyWith(hasReachedMax: false, posts: [], status: PostsStatus.loading);
      }
      if (state.posts.length == 0) yield state.copyWith(status: PostsStatus.loading);
      final array = await _fetchData(event.id, state.posts.length ~/ pageSize);
      print("The size is ${array.length}");
      if (array == null) {
        yield state.copyWith(
          status: PostsStatus.failed,
        );
        return;
      } else {
        List<Posts> commonItemsList = state.posts;
        if (commonItemsList.length == 0) {
          yield state.copyWith(
              posts: array,
              hasReachedMax: hasReachedMax(array.length),
              status: PostsStatus.success);
          return;
        }
        for (int i = 0; i < array.length; i++) commonItemsList.add(array[i]);
        yield state.copyWith(
            posts: commonItemsList,
            hasReachedMax: hasReachedMax(array.length),
            status: PostsStatus.success);
      }
    } catch (e) {
      yield state.copyWith(status: PostsStatus.failed);
    }
  }

  Future<List<Posts>> _fetchData(int id, int page) async {
    Either<Failure, PostsModel> result =
        await getPostsByTap(GetPostsForSelectedTagsParams(tabId: id, pageNumber: page));
    return result.fold((failure) {
      if (failure is MissingParamException)
        return null;
      else {
        return null;
      }
    }, (body) {
      return body.data.data;
    });
  }

  Stream<PostState> _mapAddNewPost(AddNewPost event) async* {
    if (event.title.trim().length == 0) {
      yield InvalidState(errorMessage: "Please Enter The title");
      return;
    }
    if (event.description.trim().length == 0) {
      yield InvalidState(errorMessage: "Please Enter The description");
      return;
    } else if (event.tapID == -1 && event.subjectID == -1) {
      yield InvalidState(errorMessage: "Please select tags");
      return;
    }
    try {
      Either<Failure, NewPosts> result = await addNewPost(SetNewPostParam(
          description: event.description,
          tapID: event.tapID,
          title: event.title,
          subjectId: event.subjectID));
      yield result.fold((failure) {
        if (failure is MissingParamException)
          return AddNewPostFailed();
        else {
          return AddNewPostFailed();
        }
      }, (body) {
        return AddNewPostSuccess();
      });
    } catch (e) {}
  }

  bool hasReachedMax(int number) {
    if (number < pageSize) return true;
    return false;
  }
}
