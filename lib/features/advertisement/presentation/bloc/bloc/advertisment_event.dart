part of 'advertisment_bloc.dart';

abstract class AdvertismentEvent extends Equatable {
  const AdvertismentEvent();

  @override
  List<Object> get props => [];
}

class FetchAdvertismentEvent extends AdvertismentEvent {}

class FailedGettingAdsEvent extends AdvertismentEvent {}

class SuccessGettingAdsEvent extends AdvertismentEvent {}
