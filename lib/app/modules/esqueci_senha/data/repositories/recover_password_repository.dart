import 'package:app_melivra/app/core/domain/usecases/i_usecase.dart';
import 'package:app_melivra/app/core/error/exceptions.dart';
import 'package:app_melivra/app/core/error/failures.dart';
import 'package:app_melivra/app/modules/esqueci_senha/data/datasource/i_recover_password_remote_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repository/i_recover_password_repository.dart';

class RecoverPasswordRepository implements IRecoverPasswordRepository {
  final IRecoverRemoteDatasource _datasource;

  RecoverPasswordRepository({
    required IRecoverRemoteDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Either<IFailure, void>> sendValidationCode({
    required String email,
  }) async {
    try {
      await _datasource.sendValidationCode(email: email);
      return Right(voidRight);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message),
      );
    } catch (e) {
      return Left(
        ServerFailure(message: (e as ServerException).message),
      );
    }
  }

  @override
  Future<Either<IFailure, void>> validateCode({
    required String code,
    required String email,
  }) async {
    try {
      await _datasource.validateCode(code: code, email: email);
      return Right(voidRight);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message),
      );
    } catch (e) {
      return Left(
        ServerFailure(message: (e as ServerException).message),
      );
    }
  }

  @override
  Future<Either<IFailure, void>> updatePassword({
    required String code,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    try {
      await _datasource.updatePassword(
        code: code,
        email: email,
        password: password,
        passwordConfirm: passwordConfirm,
      );
      return Right(voidRight);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message),
      );
    } catch (e) {
      return Left(
        ServerFailure(message: (e as ServerException).message),
      );
    }
  }
}
