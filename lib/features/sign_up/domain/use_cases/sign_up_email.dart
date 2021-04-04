import 'package:dartz/dartz.dart';
import 'package:university/features/sign_up/domain/repositories/sign_up_repositories.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../data/models/sign_up_model.dart';

class SignUpByEmail extends UseCase<SignUpModel, SignUpParam> {
  final SignUpRepositories signUpRepositories;

  SignUpByEmail({this.signUpRepositories});
  @override
  Future<Either<Failure, SignUpModel>> call(SignUpParam params) async {
    final param = params.getParam();
    Either<Failure, SignUpModel> result = await signUpRepositories
        .signUpByEmail(param: param);
    return result;
  }
}

class SignUpParam {
  String email;
  String password;
  String firstName;
  String lastName;
  String mobile;
  int collegeId;
  int universityId;
  String collageNumber;
  SignUpParam(
      {this.collageNumber,
      this.collegeId,
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
        "college_id": collegeId,
        "university_id": universityId,
        "collage_number": collageNumber
      };
}
