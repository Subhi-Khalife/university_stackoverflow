part of 'delete_bloc.dart';

abstract class DeleteEvent extends Equatable {
  const DeleteEvent();

  @override
  List<Object> get props => [];
}

class SendingDelSearchEvent extends DeleteEvent {}

class SuccessSendingDelSearchsEvent extends DeleteEvent {}

class FailedSendingDelSearchsEvent extends DeleteEvent {}
