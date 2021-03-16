import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class DataDuplicatesFailure extends Failure {}

class MissingParamFailure extends Failure {}

class UserNotAllowedToAccessFailure extends Failure {}

class OperationFailedFailure extends Failure {}

class TokenMisMatchFailure extends Failure {}

class DataNotFoundFailure extends Failure {}

class InvalidEmailFailure extends Failure {}

class InvalidPhoneFailure extends Failure {}

class TimeOutFailure extends Failure {}

class NotAuthenticatedFailure extends Failure {}
