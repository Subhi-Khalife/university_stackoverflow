import 'package:dartz/dartz.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/features/general_question/data/models/filter_model.dart';
import 'package:university/features/general_question/data/models/year_semester_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/get_api.dart';
import '../../../../core/unified_api/handling_exception.dart';

class GetSemanticYear with HandlingExceptionRequest {
  ConstantInfo constantInfo = ConstantInfo.getInstance();
  Future<Either<Failure, YearSemesterModel>> getSemanticYear(
      Map<String, dynamic> param) async {
    GetApi getApi = GetApi(
        requestName: "Get Year Semester",
        fromJson: yearSemesterModelFromJson,
        token: constantInfo.userInfo.token,
        url: "subjects/year_semester",
        param: param);
    final request = getApi.callRequest;
    final response =
        await handlingExceptionRequest<YearSemesterModel>(requestCall: request);
    return response.fold((failure) => Left(failure), (body) => Right(body));
  }
}
