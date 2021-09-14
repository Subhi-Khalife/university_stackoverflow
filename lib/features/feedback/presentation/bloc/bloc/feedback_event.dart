part of 'feedback_bloc.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

class SendingFeedbackEvent extends FeedbackEvent {
  final String email;
  final String message;
  final String name;
  final BuildContext context;
  SendingFeedbackEvent({
    this.email,
    this.message,
    this.name,
    @required this.context,
  });
}

class SuccessSendingFeedbackEvent extends FeedbackEvent {}

class FailedSendingFeedbackEvent extends FeedbackEvent {}
