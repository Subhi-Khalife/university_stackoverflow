part of 'collage_profile_bloc.dart';

abstract class CollageProfileEvent extends Equatable {
  const CollageProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchCollageProfile extends CollageProfileEvent {
 final int collageId;

  FetchCollageProfile({this.collageId});
}

class FailedGettingCollageProfile extends CollageProfileEvent {}

class SuccessGettingCollageProfile extends CollageProfileEvent {}
