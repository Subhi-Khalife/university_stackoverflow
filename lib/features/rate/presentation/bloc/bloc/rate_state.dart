part of 'rate_bloc.dart';

abstract class RateState extends Equatable {
  const RateState();

  @override
  List<Object> get props => [];
}

class RateInitial extends RateState {}

class LoadingRateState extends RateState {}

class SuccessSendingPostRateState extends RateState {
  final RateModel rateModel;

  SuccessSendingPostRateState(
    this.rateModel,
  );
}

class FailedSendingPostRateState extends RateState {}
