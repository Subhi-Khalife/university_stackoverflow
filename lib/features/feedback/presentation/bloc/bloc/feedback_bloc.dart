import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../../data/models/feedback_model.dart';
import '../../../data/repositories/feedback_repository_impl.dart';
import '../../../domain/usecases/feedback_use_case.dart';

part 'feedback_event.dart';

part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc() : super(FeedbackInitial());

  UseCase sendFeedback = FeedbackUseCase(
    feedbackRepository: FeedbackRepositoryImpl(),
  );

  @override
  Stream<FeedbackState> mapEventToState(
    FeedbackEvent event,
  ) async* {
    if (event is SendingFeedbackEvent) {
      yield LoadingFeedbackState();
      Either<Failure, FeedbackModel> result = await sendFeedback(
        GetFeedbackParam(
          feedbackEmail: event.email,
          feedbackMessage: event.message,
          feedbackName: event.name,
        ),
      );
      yield result.fold(
        (failure) => FailedSendingFeedbackState(),
        (successAdsModel) => SuccessSendingFeedbackState(successAdsModel),
      );
    }
  }
}
