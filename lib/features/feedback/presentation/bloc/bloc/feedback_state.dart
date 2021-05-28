part of 'feedback_bloc.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

class FeedbackInitial extends FeedbackState {}

class LoadingFeedbackState extends FeedbackState {}

class SuccessSendingFeedbackState extends FeedbackState {
  final FeedbackModel feedbackModel;

  SuccessSendingFeedbackState(
    this.feedbackModel,
  );
}

class FailedSendingFeedbackState extends FeedbackState {}
