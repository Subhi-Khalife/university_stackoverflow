import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:university/core/constant_info.dart';
import 'package:university/core/unified_api/upload_image.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception.dart';

class RemoteUploadImage with HandlingExceptionRequest {
  Future<Either<Failure, String>> setNewImage(File file) async {
    ConstantInfo constantInfo = ConstantInfo.getInstance();
    final postApi =
        UploadImageApi(token: constantInfo.userInfo.token, file: file);
    final callRequest = postApi.callRequest;
    Either<Failure, String> result =
        await handlingExceptionRequest<String>(requestCall: callRequest);
    return result;
  }
}
