import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/rate/data/models/rate_model.dart';
import 'package:university/features/rate/data/repositories/rate_repo_impl.dart';
import 'package:university/features/rate/domain/usecases/rate_usecase.dart';

part 'rate_event.dart';

part 'rate_state.dart';

class RateBloc extends Bloc<RateEvent, RateState> {
  RateBloc() : super(RateInitial());

  UseCase postRate = RateUsecase(
    rateRepository: RateRepoImpl(),
  );

  @override
  Stream<RateState> mapEventToState(
    RateEvent event,
  ) async* {
    if (event is SendingPostRateEvent) {
      yield LoadingRateState();
      Either<Failure, RateModel> result = await postRate(
        GetRateParam(
          commentId: event.commentId,
          postId: event.postId,
          rate: event.rate,
        ),
      );
      yield result.fold(
        (failure) => FailedSendingPostRateState(),
        (successRateModel) => SuccessSendingPostRateState(successRateModel),
      );
    }
  }
}
