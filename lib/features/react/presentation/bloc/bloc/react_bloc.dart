import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/react/data/models/react_model.dart';
import 'package:university/features/react/data/repositories/react_repository_impl.dart';
import 'package:university/features/react/domain/usecases/react_usecase.dart';

part 'react_event.dart';

part 'react_state.dart';

class ReactBloc extends Bloc<ReactEvent, ReactState> {
  ReactBloc() : super(ReactInitial());

  UseCase sendFeedback = ReactUsecase(
    reactRepository: ReactRepositoryImpl(),
  );

  @override
  Stream<ReactState> mapEventToState(
    ReactEvent event,
  ) async* {
    if (event is SendingPostReactEvent) {
      yield LoadingReactState();
      Either<Failure, ReactModel> result = await sendFeedback(GetReactParam(
        commentId: event.commmentId,
        postId: event.postId,
        type: event.type,
      ));
      yield result.fold(
        (failure) => FailedSendingReactState(),
        (successReactModel) => SuccessSendingReactState(successReactModel),
      );
    }
  }
}
