import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/user_searches/search/data/models/add_search_model.dart';
import 'package:university/features/user_searches/search/domain/repositories/add_search_repository.dart';

class AddSearchUsecase extends UseCase<AddSearchModel, GetPostSearchsParam> {
  final AddSearchRepository addSearchRepository;

  AddSearchUsecase({this.addSearchRepository});

  @override
  Future<Either<Failure, AddSearchModel>> call(
      GetPostSearchsParam getSearchsParam) async {
    final result = await addSearchRepository.postSearchs(
      items: getSearchsParam.getParam(),
    );
    return result;
  }
}

class GetPostSearchsParam {
  final String searchText;

  GetPostSearchsParam({
    this.searchText,
  });

  getParam() => {
        "search_text": searchText,
      };
}
