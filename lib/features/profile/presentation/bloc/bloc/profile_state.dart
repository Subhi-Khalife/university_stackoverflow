part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileIsLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileIsLoadedState extends ProfileState {
  final User user;

  ProfileIsLoadedState({this.user});

  @override
  List<Object> get props => [this.user];
}

class ProfileIsLoadErrorState extends ProfileState {
  @override
  List<Object> get props => [];
}
