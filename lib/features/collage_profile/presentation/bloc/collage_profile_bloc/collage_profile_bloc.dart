import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/collage_profile/data/models/collage_profile.dart';
import 'package:university/features/collage_profile/data/repository/collage_profile_repository_impl.dart';
import 'package:university/features/collage_profile/domain/usecases/collage_Profile_usercase.dart';

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
      yield GettingCollageProfileLoadingState();
      Either<Failure, CollageProfileModel> result = await getCollageProfile(6);
      yield result.fold(
        (failure) => GettingCollageProfileFailed(),
        (r) => GettingCollageProfileSuccess(r),
      );
    }
    // TODO: implement mapEventToState
  }
}
