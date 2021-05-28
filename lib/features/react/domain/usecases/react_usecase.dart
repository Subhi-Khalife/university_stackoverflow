import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/react/data/models/react_model.dart';
import 'package:university/features/react/domain/repositories/react_repository.dart';

class ReactUsecase extends UseCase<ReactModel, GetReactParam> {
  final ReactRepository reactRepository;

  ReactUsecase({this.reactRepository});

  @override
  Future<Either<Failure, ReactModel>> call(GetReactParam getReactParam) async {
    final result = await reactRepository.postReacts(
      items: getReactParam.getParam(),
    );
    return result;
  }
}

class GetReactParam {
  final String postId;
  final String commentId;
  final String type;

  GetReactParam({this.postId, this.commentId, this.type});

  getParam() => {
        "post_id": postId,
        "comment_id": commentId,
        "type": type,
      };
}
