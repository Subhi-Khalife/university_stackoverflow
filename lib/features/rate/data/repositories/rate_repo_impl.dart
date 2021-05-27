import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/features/rate/data/data_source/remote_post_rate.dart';
import 'package:university/features/rate/data/models/rate_model.dart';
import 'package:university/features/rate/domain/repositories/rate_repository.dart';

class RateRepoImpl implements RateRepository {
  @override
  Future<Either<Failure, RateModel>> postRate(
      {Map<String, dynamic> items}) async {
    final postRate = await RemotePostRate().postRate(items);
    return postRate;
  }
}
