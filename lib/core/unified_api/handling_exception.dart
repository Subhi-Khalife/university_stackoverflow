import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../error/exception.dart';
import '../error/failures.dart';

typedef Future<T> _RequestCall<T>();

mixin HandlingExceptionRequest {
  Exception getException({@required int statusCode}) {
    if (statusCode == 330)
      return DataDuplicatesException();
    else if (statusCode == 400 || statusCode == 422)
      return MissingParamException();
    else if (statusCode == 430)
      return NotAuthenticatedException();
    else if (statusCode == 460 || statusCode == 550)
      return UserNotAllowedToAccessException();
    else if (statusCode == 560)
      return OperationFailedException();
    else if (statusCode == 499)
      return TokenMisMatchException();
    else if (statusCode == 401)
      return DataNotFoundException();
    else if (statusCode == 522)
      return InvalidEmailException();
    else if (statusCode == 477)
      return InvalidPhoneException();
    else
      return ServerException();
  }

  Future<Either<Failure, T>> handlingExceptionRequest<T>(
      {@required _RequestCall requestCall}) async {
    try {
      final response = await requestCall();
      return Right(response);
    } on ServerException {
      print("<< ServerException >> ");
      return Left(ServerFailure());
    } on DataDuplicatesException {
      print("<< DataDuplicatesException >> ");
      return Left(DataDuplicatesFailure());
    } on MissingParamException {
      print("<< MissingParamException >> ");
      return Left(MissingParamFailure());
    } on UserNotAllowedToAccessException {
      print("<< UserNotAllowedToAccessException >> ");
      log("message");
      return Left(UserNotAllowedToAccessFailure());
    } on OperationFailedException {
      print("<< OperationFailedException >> ");
      return Left(OperationFailedFailure());
    } on TokenMisMatchException {
      print("<< TokenMisMatchException >> ");
      return Left(TokenMisMatchFailure());
    } on DataNotFoundException {
      print("<< DataNotFoundException >> ");
      return Left(DataNotFoundFailure());
    } on InvalidEmailException {
      print("<< InvalidEmailException >> ");
      return Left(InvalidEmailFailure());
    } on InvalidPhoneException {
      print("<< InvalidPhoneException >> ");
      return Left(InvalidPhoneFailure());
    } on NotAuthenticatedException {
      print("<< NotAuthenticatedException >> ");
      return Left(NotAuthenticatedFailure());
    } on TimeoutException {
      print("<< TimeoutException >> ");
      return Left(TimeOutFailure());
    } catch (e) {
      print("<< catch >> error is $e");
      return Left(ServerFailure());
    }
  }
}
