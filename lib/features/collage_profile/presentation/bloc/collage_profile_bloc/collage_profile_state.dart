part of 'collage_profile_bloc.dart';

abstract class CollageProfileState  {
  const CollageProfileState();

}

class CollageProfileInitial extends CollageProfileState {}

class GettingCollageProfileSuccess extends CollageProfileState {
  final CollageProfileModel collageProfileModel;

  GettingCollageProfileSuccess(this.collageProfileModel);
}

class GettingCollageProfileFailed extends CollageProfileState {}

class GettingCollageProfileLoadingState extends CollageProfileState {}
