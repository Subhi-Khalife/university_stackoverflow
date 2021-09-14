import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../../data/models/collage_profile.dart';
import '../../../data/repository/collage_profile_repository_impl.dart';
import '../../../domain/usecases/collage_Profile_usercase.dart';

part 'collage_profile_event.dart';
part 'collage_profile_state.dart';

class CollageProfileBloc
    extends Bloc<CollageProfileEvent, CollageProfileState> {
  CollageProfileBloc() : super(CollageProfileInitial());
  UseCase getCollageProfile = CollageProfileUseCase(
    collageProfileRepository: CollageProfileRepositoryImpl(),
  );

  @override
  Stream<CollageProfileState> mapEventToState(
    CollageProfileEvent event,
  ) async* {
    if (event is FetchCollageProfile) {
      yield* _mapFetchCollageProfile(event);
    }
  }

  Stream<CollageProfileState> _mapFetchCollageProfile(
      FetchCollageProfile event) async* {
    yield GettingCollageProfileLoadingState();
    Either<Failure, CollageProfileModel> result = await getCollageProfile(event.collageId);
    yield result.fold(
      (failure) => GettingCollageProfileFailed(),
      (successCollageProfileModel) =>
          GettingCollageProfileSuccess(successCollageProfileModel),
    );
  }
}
