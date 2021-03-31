part of 'university_bloc.dart';

abstract class UniversityEvent extends Equatable {
  const UniversityEvent();

  @override
  List<Object> get props => [];
}

class FetchUiversity extends UniversityEvent {
  FetchUiversity();

  @override
  List<Object> get props => [];
}

class SelectedUniversityEvent extends UniversityEvent {
  final String universityName;
  final int universityId;
  final int index;
  SelectedUniversityEvent({this.universityId, this.universityName,this.index});
}

class SelectedCollageEvent extends UniversityEvent {
  final String collageName;
  final int collageIndex;
  SelectedCollageEvent({this.collageIndex, this.collageName});
}
