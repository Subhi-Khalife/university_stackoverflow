import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/rate/data/models/rate_model.dart';
import 'package:university/features/rate/domain/repositories/rate_repository.dart';

class RateUsecase extends UseCase<RateModel, GetRateParam> {
  final RateRepository rateRepository;

  RateUsecase({this.rateRepository});

  @override
  Future<Either<Failure, RateModel>> call(GetRateParam getRateParam) async {
    final result = await rateRepository.postRate(
      items: getRateParam.getParam(),
    );
    return result;
  }
}

class GetRateParam {
  final String postId;
  final String commentId;
  final String rate;

  GetRateParam({this.postId, this.commentId, this.rate});

  getParam() => {
        "post_id": postId,
        "comment_id": commentId,
        "rate": rate,
      };
}
