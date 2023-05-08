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
  Future<Either<IFailure, void>> validateCode({required String code}) async {
    try {
      await _datasource.validateCode(code: code);
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
