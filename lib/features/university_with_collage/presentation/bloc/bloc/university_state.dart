part of 'university_bloc.dart';

class UniversityState {
  final String universityName;
  final int universityId;
  final String collageName;
  final int collageId;
  final List<DropDownItem> univerSityItems;
  final List<DropDownItem> collegeityItems;
  final UniversitiesWithCollegesModel universityObject; 
  UniversityState({
    this.universityName = "select you university",
    this.universityId = -1,
    this.collageId = -1,
    this.collageName = "Select you Collage",
    this.univerSityItems= const <DropDownItem>[],
    this.collegeityItems=const <DropDownItem>[],
    this.universityObject
  });

  copyWith(
      {String universityName,
      int universityId,
      String collageName,
      int collageId,
      List<DropDownItem> univerSityItems,
      List<DropDownItem> collegeityItems,
      UniversitiesWithCollegesModel universityObject
      }) {
    return UniversityState(
        universityId: (universityId) ?? this.universityId,
        universityName: (universityName) ?? this.universityName,
        collageId: (collageId)??this.collageId,
        collageName: (collageName)??this.collageName,
        univerSityItems: (univerSityItems)??this.univerSityItems,
        collegeityItems:(collegeityItems)??this.collegeityItems,
        universityObject:(universityObject)??this.universityObject
        );

  }
}

class UniversityIsLoadingState extends UniversityState {}


class UniversityIsLoadErrorState extends UniversityState {}

class UniversitySelectedState extends UniversityState {}
