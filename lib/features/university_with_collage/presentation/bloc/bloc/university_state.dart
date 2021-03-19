part of 'university_bloc.dart';

abstract class UniversityState extends Equatable {
  const UniversityState();

  @override
  List<Object> get props => [];
}

class UniversityInitial extends UniversityState {
  @override
  List<Object> get props => [];
}

class UniversityIsLoadingState extends UniversityState {
  @override
  List<Object> get props => [];
}

class UniversityIsLoadedState extends UniversityState {
  final UniversitiesWithCollegesModel university;

  UniversityIsLoadedState({this.university});

  @override
  List<Object> get props => [this.university];
}

class UniversityIsLoadErrorState extends UniversityState {
  // final String error;

  // UniversityIsLoadErrorState({this.error});

  @override
  List<Object> get props => [];
}
