part of 'collage_profile_bloc.dart';

abstract class CollageProfileState extends Equatable {
  const CollageProfileState();

  @override
  List<Object> get props => [];
}

class CollageProfileInitial extends CollageProfileState {}

class GettingCollageProfileSuccess extends CollageProfileState {
  final CollageProfileModel collageProfileModel;

  GettingCollageProfileSuccess(this.collageProfileModel);
}

class GettingCollageProfileFailed extends CollageProfileState {}

class GettingCollageProfileLoadingState extends CollageProfileState {}
