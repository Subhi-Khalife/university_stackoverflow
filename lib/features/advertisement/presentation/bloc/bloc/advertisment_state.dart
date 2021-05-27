part of 'advertisment_bloc.dart';

abstract class AdvertismentState extends Equatable {
  const AdvertismentState();

  @override
  List<Object> get props => [];
}

class AdvertismentInitial extends AdvertismentState {}

class SuccessGettingAdsState extends AdvertismentState {
  final AdvertisementModel advertisementModel;

  SuccessGettingAdsState(
    this.advertisementModel,
  );
}

class FailedGettingAdsState extends AdvertismentState {}

class LoadingAdsState extends AdvertismentState {}
