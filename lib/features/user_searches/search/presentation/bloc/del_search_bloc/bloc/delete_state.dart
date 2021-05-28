part of 'delete_bloc.dart';

abstract class DeleteState extends Equatable {
  const DeleteState();

  @override
  List<Object> get props => [];
}

class DeleteInitial extends DeleteState {}

class LoadingDelSearchState extends DeleteState {}

class SuccessSendingDelSearchState extends DeleteState {
  final DelSearchModel delSearchModel;

  SuccessSendingDelSearchState(
    this.delSearchModel,
  );
}

class FailedSendingDelSearchState extends DeleteState {}
