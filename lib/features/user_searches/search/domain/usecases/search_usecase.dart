import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/use_case/use_case.dart';
import '../../data/models/search_model.dart';
import '../repositories/search_repository.dart';

class SearchUseCase extends UseCase<SearchModel, GetSearchsParam> {
  final SearchRepository searchRepository;

  SearchUseCase({this.searchRepository});

  @override
  Future<Either<Failure, SearchModel>> call(
      GetSearchsParam getSearchsParam) async {
    final result = await searchRepository.getSearchs();
    return result;
  }
}

class GetSearchsParam {}
