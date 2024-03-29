import 'package:app_melivra/app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class IRecoverPasswordRepository {
  Future<Either<IFailure, void>> sendValidationCode({required String email});
  Future<Either<IFailure, void>> validateCode({
    required String code,
    required String email,
  });
  Future<Either<IFailure, void>> updatePassword({
    required String code,
    required String email,
    required String password,
    required String passwordConfirm,
  });
}
