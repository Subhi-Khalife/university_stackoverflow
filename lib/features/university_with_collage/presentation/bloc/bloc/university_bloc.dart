import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/error/exception.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/university_with_collage/data/models/universities_with_collages_model.dart';
import 'package:university/features/university_with_collage/data/repositories/university_with_collage_impl.dart';
import 'package:university/features/university_with_collage/domain/use_cases/get_all_university_with_collage.dart';

part 'university_event.dart';
part 'university_state.dart';

class UniversityBloc extends Bloc<UniversityEvent, UniversityState> {
  UniversityBloc() : super(UniversityInitial());
  UseCase getAllUniversityWithCollage = GetAllUniversityWithCollage(
    universityWithCollageRepositories: UniversityWithCollageImpl(),
  );

  @override
  Stream<UniversityState> mapEventToState(
    UniversityEvent event,
  ) async* {
    if (event is FetchUiversity) {
      yield UniversityIsLoadingState();
      final result = await getAllUniversityWithCollage(NoParams());
      yield result.fold(
        (failure) => failure is MissingParamException
            ? UniversityIsLoadErrorState()
            : UniversityIsLoadErrorState(),
        (success) => UniversityIsLoadedState(university: success),
      );
    }
  }
}
