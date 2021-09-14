import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/entities/user.dart';
import '../../../../../core/error/exception.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../../data/repositories/profile_repositories_impl.dart';
import '../../../domain/usecases/get_profile_for_user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());
  UseCase getUserProfileCall =
      GetProfileForUser(profileRepository: ProfileRepositoryImpl());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is FetchProfile) {
      yield ProfileIsLoadingState();
      final result = await getUserProfileCall(NoParams());
      yield result.fold(
        (failure) => failure is MissingParamException
            ? ProfileIsLoadErrorState()
            : ProfileIsLoadErrorState(),
        (success) {
          return ProfileIsLoadedState(user: success);
        },
      );
    }
  }
}
