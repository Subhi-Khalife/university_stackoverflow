part of 'rate_bloc.dart';

abstract class RateEvent extends Equatable {
  const RateEvent();

  @override
  List<Object> get props => [];
}

class SendingPostRateEvent extends RateEvent {
  final String postId;
  final String commentId;
  final String rate;

  SendingPostRateEvent({
    this.postId,
    this.commentId,
    this.rate,
  });
}

class SuccessSendingPostRateEvent extends RateEvent {}

class FailedSendingPostRateEvent extends RateEvent {}
