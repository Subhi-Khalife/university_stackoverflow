import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:university/core/error/failures.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/post/domain/repositories/post_repositories.dart';

class UploadImageUseCase extends UseCase<String, File> {
  PostRepositories postRepositories;
  UploadImageUseCase({this.postRepositories});
  @override
  Future<Either<Failure, String>> call(File params) async {
    final value = await postRepositories.uploadImage(items: params);
    return value.fold(
      (failure) => left(failure),
      (success) => right(success),
    );
  }
}
