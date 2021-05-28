part of 'react_bloc.dart';

abstract class ReactEvent extends Equatable {
  const ReactEvent();

  @override
  List<Object> get props => [];
}

class SendingPostReactEvent extends ReactEvent {
  final String postId;
  final String commmentId;
  final String type;

  SendingPostReactEvent({
    this.postId,
    this.commmentId,
    this.type,
  });
}

class SuccessSendingPostReactEvent extends ReactEvent {}

class FailedSendingPostReactEvent extends ReactEvent {}
