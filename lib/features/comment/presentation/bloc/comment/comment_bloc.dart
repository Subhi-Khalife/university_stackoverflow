import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/entities/comment.dart';
import 'package:university/core/error/exception.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/comment/data/data_sources/add_new_comment.dart';
import 'package:university/features/comment/data/models/add_comment_response.dart';
import 'package:university/features/comment/data/repositories/comment_repositories_implementation.dart';
import 'package:university/features/comment/domain/use_cases/add_new_comment.dart';
import 'package:university/features/comment/domain/use_cases/delete_comment.dart';
import 'package:university/features/comment/domain/use_cases/update_comment.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial());
  UseCase<AddCommentResponse, AddNewComments> addNewComment =
      AddNewCommentUseCase(
          commentRepositories: CommentRepositoriesImplemintation());

  UseCase<AddCommentResponse, UpdateCommentParams> updateComment =
      UpdateCommentUseCase(
          commentRepositories: CommentRepositoriesImplemintation());

  UseCase<bool, int> deleteComment = DeleteCommentUseCase(
      commentRepositories: CommentRepositoriesImplemintation());
  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is AddNewComment) {
      yield* _mapAddNewComment(event);
    } else if (event is UpdateComment) {
      yield* _mapUpdateComment(event);
    } else if (event is DeleteComment) {
      yield* _mapDeleteComment(event);
    }
  }

  Stream<CommentState> _mapDeleteComment(DeleteComment event) async* {
    try {
      yield LoadingState();
      Either<Failure, bool> result = await deleteComment(event.commentId);
      yield result.fold((failure) {
        if (failure is MissingParamException)
          return Failed(errorMessage: "Error Happened try again");
        else {
          return Failed(errorMessage: "Error Happened try again");
        }
      }, (body) {
        return SuccessDeleteComment(index: event.commentIndex);
      });
    } catch (e) {}
  }

  Stream<CommentState> _mapUpdateComment(UpdateComment event) async* {
    try {
      yield LoadingState();
      Either<Failure, AddCommentResponse> result = await updateComment(
          UpdateCommentParams(
              commentId: event.commentId, description: event.description));
      yield result.fold((failure) {
        if (failure is MissingParamException)
          return Failed(errorMessage: "Error Happened try again");
        else {
          return Failed(errorMessage: "Error Happened try again");
        }
      }, (body) {
        Comment item = body.data;
        ConstantInfo constantInfo = ConstantInfo.getInstance();
        item.user = constantInfo.userInfo;
        return SuccessUpdateComment(
            index: event.commentIndex, addCommentResponse: item);
      });
    } catch (e) {}
  }

  Stream<CommentState> _mapAddNewComment(AddNewComment event) async* {
    try {
      yield LoadingState();
      Either<Failure, AddCommentResponse> result =
          await addNewComment(AddNewComments(
        commentId: event.commentId,
        description: event.description,
        postId: event.postId,
      ));
      yield result.fold((failure) {
        if (failure is MissingParamException)
          return Failed(errorMessage: "Error Happened try again");
        else {
          return Failed(errorMessage: "Error Happened try again");
        }
      }, (body) {
        Comment item = body.data;
        ConstantInfo constantInfo = ConstantInfo.getInstance();
        item.user = constantInfo.userInfo;
        return SuccessAddNewComment(addCommentResponse: item);
      });
    } catch (e) {}
  }
}
