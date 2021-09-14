import 'package:dartz/dartz.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/features/general_question/data/models/filter_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/get_api.dart';
import '../../../../core/unified_api/handling_exception.dart';

class GetFiltters with HandlingExceptionRequest {
  ConstantInfo constantInfo = ConstantInfo.getInstance();
  Future<Either<Failure, FilterModel>> getAllFilters(
      {String collageId}) async {
    GetApi getApi = GetApi(
        requestName: "Get All Filters",
        fromJson: filterModelFromJson,
        token: constantInfo.userInfo.token,
        url: "subjects/get_filters");
    final request = getApi.callRequest;
    final response =
        await handlingExceptionRequest<FilterModel>(requestCall: request);
    return response.fold((failure) => Left(failure), (body) => Right(body));
  }
}
