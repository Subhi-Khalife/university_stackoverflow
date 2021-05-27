part of 'react_bloc.dart';

abstract class ReactState extends Equatable {
  const ReactState();

  @override
  List<Object> get props => [];
}

class ReactInitial extends ReactState {}

class LoadingReactState extends ReactState {}

class SuccessSendingReactState extends ReactState {
  final ReactModel reactModel;

  SuccessSendingReactState(
    this.reactModel,
  );
}

class FailedSendingReactState extends ReactState {}
