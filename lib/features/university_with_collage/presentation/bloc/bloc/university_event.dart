part of 'university_bloc.dart';

abstract class UniversityEvent  {
  const UniversityEvent();

}

class FetchUiversity extends UniversityEvent {
  FetchUiversity();

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
