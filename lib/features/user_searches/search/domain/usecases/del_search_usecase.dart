import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/user_searches/search/data/models/del_search_model.dart';
import 'package:university/features/user_searches/search/domain/repositories/del_search_repository.dart';

class DelSearchUsecase extends UseCase<DelSearchModel, GetDelSearchParam> {
  final DelSearchRepository delSearchRepository;

  DelSearchUsecase({this.delSearchRepository});

  @override
  Future<Either<Failure, DelSearchModel>> call(
      GetDelSearchParam getDelSearchParam) async {
    final result = await delSearchRepository.delSearchs();
    return result;
  }
}

class GetDelSearchParam {}
