import 'package:dartz/dartz.dart';

import '../../../../core/domain/usecases/i_usecase.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/services/i_update_perfil_service.dart';
import '../datasource/i_update_perfil_datasource.dart';

class UpdatePerfilService implements IUpdatePerfilService {
  final IUpdatePerfilDatasource _updatePerfilRemoteDatasource;
  UpdatePerfilService({
    required IUpdatePerfilDatasource updatePerfilRemoteDatasource,
  }) : _updatePerfilRemoteDatasource = updatePerfilRemoteDatasource;
  @override
  Future<Either<IFailure, void>> call({
    required String name,
    required String email,
  }) async {
    try {
      await _updatePerfilRemoteDatasource.update(
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
}
