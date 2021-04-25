import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/entities/collega.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../../data/models/universities_with_collages_model.dart';
import '../../../data/repositories/university_with_collage_impl.dart';
import '../../../domain/use_cases/get_all_university_with_collage.dart';
import '../../pages/drop_down.dart';

part 'university_event.dart';
part 'university_state.dart';

class UniversityBloc extends Bloc<UniversityEvent, UniversityState> {
  UniversityBloc() : super(UniversityState());
  UseCase getAllUniversityWithCollage = GetAllUniversityWithCollage(
    universityWithCollageRepositories: UniversityWithCollageImpl(),
  );

  @override
  Stream<UniversityState> mapEventToState(
    UniversityEvent event,
  ) async* {
    if (event is FetchUiversity) {
      yield* _mapFetchUiversity();
    } else if (event is SelectedUniversityEvent) {
      yield* _mapSelectedUniversityEvent(event);
    } else if (event is SelectedCollageEvent) {
      yield state.copyWith(
          collageId: event.collageIndex, collageName: event.collageName);
    }
  }

  Stream<UniversityState> _mapSelectedUniversityEvent(
      SelectedUniversityEvent event) async* {
    List<DropDownItem> collegeItem = List<DropDownItem>();
    List<College> _collegeList =
        state.universityObject.data[event.index].colleges;
    for (int i = 0; i < _collegeList.length; i++) {
      collegeItem.add(
          DropDownItem(id: _collegeList[i].id, title: _collegeList[i].name));
    }
    yield state.copyWith(
        universityId: event.universityId,
        universityName: event.universityName,
        collegeityItems: collegeItem);
  }

  Stream<UniversityState> _mapFetchUiversity() async* {
    yield UniversityIsLoadingState();
    final result = await getAllUniversityWithCollage(NoParams());
    yield result.fold(
        (failure) => failure is MissingParamException
            ? UniversityIsLoadErrorState()
            : UniversityIsLoadErrorState(), (success) {
      UniversitiesWithCollegesModel universitiesWithCollegesModel = success;
      List<DropDownItem> universityItem = List<DropDownItem>();
      for (int i = 0; i < universitiesWithCollegesModel.data.length; i++) {
        universityItem.add(DropDownItem(
            id: universitiesWithCollegesModel.data[i].id,
            title: universitiesWithCollegesModel.data[i].name));
      }
      return state.copyWith(
          univerSityItems: universityItem,
          universityObject: universitiesWithCollegesModel);
    });
  }
}
