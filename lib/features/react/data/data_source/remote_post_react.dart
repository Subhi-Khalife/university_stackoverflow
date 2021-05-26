import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/unified_api/handling_exception.dart';
import 'package:university/core/unified_api/post_api.dart';
import 'package:university/features/react/data/models/react_model.dart';

class RemotePostReact with HandlingExceptionRequest {
  Future<Either<Failure, ReactModel>> postReacts(
      {Map<String, dynamic> param}) async {
    final postApi = PostApi<ReactModel>(
      param: param,
      fromJson: reactModelFromJson,
      url: "reacts",
      requestName: "post reacts",
    );
    final callRequest = postApi.callRequest;
    Either<Failure, ReactModel> result =
        await postApi.handlingExceptionRequest(requestCall: callRequest);
    return result;
  }
}
