import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/i_usecase.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repository/i_perfil_repository.dart';
import '../datasource/i_perfil_datasource.dart';

class PerfilRepository implements IPerfilRepository {
  final IPerfilDatasource _perfilRemoteDatasource;

  PerfilRepository({
    required IPerfilDatasource perfilRemoteDatasource,
  }) : _perfilRemoteDatasource = perfilRemoteDatasource;
  @override
  Future<Either<IFailure, void>> update({
    required String name,
    required String email,
  }) async {
    try {
      await _perfilRemoteDatasource.update(
        email: email,
        name: name,
      );
      return Right(voidRight);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message),
      );
    }
  }

  @override
  Future<Either<IFailure, void>> delete() async {
    try {
      await _perfilRemoteDatasource.delete();
      return Right(voidRight);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message),
      );
    }
  }
}
