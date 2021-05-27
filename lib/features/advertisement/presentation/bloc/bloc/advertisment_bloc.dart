import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../../data/models/advertisment.dart';
import '../../../data/repositories/advertisment_repository_impl.dart';
import '../../../domain/usecases/advertisment_usecase.dart';

part 'advertisment_event.dart';

part 'advertisment_state.dart';

class AdvertismentBloc extends Bloc<AdvertismentEvent, AdvertismentState> {
  AdvertismentBloc() : super(AdvertismentInitial());

  UseCase getAds = AdvertismentUseCase(
    adsRepository: AdvertismentRepositoryImpl(),
  );

  @override
  Stream<AdvertismentState> mapEventToState(
    AdvertismentEvent event,
  ) async* {
    if (event is FetchAdvertismentEvent) {
      yield LoadingAdsState();
      Either<Failure, AdvertisementModel> result = await getAds(null);
      yield result.fold(
        (failure) => FailedGettingAdsState(),
        (successAdsModel) => SuccessGettingAdsState(successAdsModel),
      );
    }
    // TODO: implement mapEventToState
  }
}
