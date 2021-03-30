import 'package:university/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:university/core/use_case/use_case.dart';
import 'package:university/features/sign_up/data/models/sign_up_model.dart';
import 'package:university/features/sign_up/data/repositories/sign_up_repositories_implementation.dart';

class SignUpByEmail extends UseCase<SignUpModel, SignUpParam> {
  @override
  Future<Either<Failure, SignUpModel>> call(SignUpParam params) async {
    final param = params.getParam();
    final result =
        await SignUpRepositoriesImplimentation().signUpByEmail(param);
    return result.fold((failure) => Left(failure), (body) => Right(body));
  }
}

class SignUpParam {
  String email;
  String password;
  String firstName;
  String lastName;
  String mobile;
  int collegaId;
  int universityId;
  String collageNumber;
  SignUpParam(
      {this.collageNumber,
      this.collegaId,
      this.email,
      this.firstName,
      this.lastName,
      this.mobile,
      this.password,
      this.universityId});
  Map<String, dynamic> getParam() => {
        "email": email,
        "password": password,
        "first_name": lastName,
        "last_name": lastName,
        "mobile": mobile,
        "college_id": collegaId,
        "university_id": universityId,
        "collage_number": collageNumber
      };
}
